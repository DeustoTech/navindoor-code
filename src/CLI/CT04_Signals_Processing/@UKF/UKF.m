classdef UKF < handle
%

% Leave the above row empty to suppress the message: "Help for X is
% inherited from superclass matlabshared.tracking.internal.UnscentedKalmanFilter"

%UnscentedKalmanFilter   Unscented Kalman filter for object tracking
    %   This unscented Kalman filter is designed for tracking. You can use
    %   it to predict object's future location, to reduce noise in the
    %   detected location, or to help associate multiple objects with their
    %   tracks. The unscented Kalman filter is used for tracking objects
    %   that move according to a nonlinear motion model, or that are
    %   measured by a nonlinear measurement model.
    %
    %   The unscented Kalman filter algorithm implements a discrete time,
    %   nonlinear State-Space System described as follows.
    %
    %   Additive noise models:
    %      x(k) = f(x(k-1), u(k-1)) + w(k-1)         (state equation)
    %      z(k) = h(x(k)) + v(k)                     (measurement equation)
    %
    %   Non-additive noise models:
    %      x(k) = f(x(k-1), w(k-1), u(k-1))          (state equation)
    %      z(k) = h(x(k), v(k))                      (measurement equation)
    %
    %   The unscented Kalman filter attempts to estimate the uncertainty
    %   about the state, and its propagation through the nonlinear state
    %   and measurement equations, using a fixed number of "Sigma Points".
    %   These points are chosen using the Unscented Transformation, and are
    %   governed by three parameters: Alpha, Beta, and Kappa. The valid
    %   ranges of values for these parameters are (default values are in
    %   paranthesis):
    %       0 <  Alpha <= 1     (1e-3)
    %       0 <= Beta           (2)
    %       0 <= Kappa <= 3     (0)
    %   See [1,2] for more information about these parameters.
    %
    %   The unscented Kalman filter algorithm involves two steps.
    %      * Predict: Using the current state to predict the next state.
    %      * Correct, also known as update: Using the current measurement,
    %           such as the detected object location, to correct the state.
    %
    %
    %   Constructing an UnscentedKalmanFilter object:
    %
    %   UKF = UnscentedKalmanFilter returns an unscented Kalman filter
    %   object with default state transition function and measurement
    %   function and assumes an additive noise model.
    %
    %   UKF = UnscentedKalmanFilter(StateTransitionFcn, MeasurementFcn,
    %   State) lets you specify the state transition function, f, and the
    %   measurement function, h. Both must be specified as
    %   function_handles. In addition, it lets you specify an initial value
    %   for the state.
    %
    %   UKF = UnscentedKalmanFilter(..., Name, Value) configures the
    %   unscented Kalman filter object properties, specified as one or more
    %   name-value pair arguments. Unspecified properties have default
    %   values.
    %
    %   Using the predict method:
    %
    %   [x_pred, P_pred] = predict(UKF) returns the prediction of state and
    %   state estimation error covariance at the next time step for a model
    %   with additive noise. The internal state and state covariance are
    %   overwritten by the prediction results.
    %
    %   [x_pred, P_pred] = predict(UKF, varargin) additionally, lets you
    %   specify any parameters that will be passed to and used by the
    %   @StateTransitionFcn.
    %
    %   Using the correct method:
    %
    %   [x_corr, P_corr] = correct(UKF, z) returns the correction of the
    %   state and the state estimation error covariance based on the
    %   current measurement z, an N-element vector. The internal state and
    %   covariance are overwritten by the corrected values.
    %
    %   [x_corr, P_corr] = correct(UKF, z, varargin) additionally, lets you
    %   sepcify any parameters that will be passed to and used by the
    %   @MeasurementFcn
    %
    %   Notes:
    %   ======
    %   * If the measurement exists, e.g., the object has been detected,
    %     you can call the predict method and the correct method together.
    %     If the measurement is missing, you can call the predict method
    %     but not the correct method.
    %
    %      If the object tracked by UKF is detected
    %         predict(UKF);
    %         trackedLocation = correct(UKF, objectLocation);
    %      Else
    %         trackedLocation = predict(UKF);
    %      End
    %
    %   UnscentedKalmanFilter methods:
    %
    %   predict  - Predicts the state and state estimation error covariance
    %   correct  - Corrects the state and state estimation error covariance
    %
    %   UnscentedKalmanFilter properties:
    %
    %   HasAdditiveProcessNoise     - True if process noise is additive
    %   StateTransitionFcn          - Promotes the state to next time step, (f)
    %   HasAdditiveMeasurementNoise - True if measurement noise is additive
    %   MeasurementFcn              - Calculates the measurement, (h)
    %   State                       - State, (x)
    %   StateCovariance             - State estimation error covariance, (P)
    %   ProcessNoise                - Process noise covariance, (Q)
    %   MeasurementNoise            - Measurement noise covariance, (R)
    %   Alpha                       - Unscented transformation parameter alpha
    %   Beta                        - Unscented transformation parameter beta
    %   Kappa                       - Unscented transformation parameter kappa
    
    %   References:
    %   [1] Eric A. Wan and Rudolph van der Merwe, "The Unscented Kalman
    %       Filter for Nonlinear Estimation", Adaptive Systems for Signal
    %       Processing, Communications, and Control, pages 153-158,
    %       AS-SPCC, IEEE, 2000.
    %   [2] Wan, Merle "The Unscented Kalman Filter", chapter in Kalman
    %       Filtering and Neural Networks, John Wiley & Sons, Inc., 2001
    %   [3] Sarkka S., "Recursive Bayesian Inference on Stochastic
    %       Differential Equations", Doctoral Dissertation, Helsinki
    %       University of Technology, 2006.
    
    %   Copyright 2016 The MathWorks, Inc.
    
    %#codegen
    %#ok<*EMCLS>
    %#ok<*EMCA>
    %#ok<*MCSUP>
    
    %------------------------------------------------------------------------
    % Public properties
    %------------------------------------------------------------------------
    properties(Access=public, Dependent)
        %HasAdditiveProcessNoise A Boolean flag that defines whether the
        %noise affecting the state transition is additive (true) or
        %non-additive (false).
        HasAdditiveProcessNoise;
    end
    
    properties(Access=public)
        %StateTransitionFcn A function calculating the state at the next
        %time step (f).
        %   Specify the transition of state between times as a function
        %   that calculates an M dimensional state vector at time k given
        %   the state vector at time k-1. The function may take additional
        %   input parameters if needed, e.g., control inputs or the size of
        %   the time step.
        %
        %   If HasAdditiveProcessNoise is true, the function should have
        %   one of the following signatures:
        %       x(k) = StateTransitionFcn(x(k-1))
        %       x(k) = StateTransitionFcn(x(k-1), parameters)
        %   where:
        %       x(k) is the (estimated) state at time k.
        %       'parameters' are any additional arguments that are needed
        %       by the state transition function.
        %
        %   If HasAdditiveProcessNoise is false, the function should have
        %   one of the following signatures:
        %       x(k) = StateTransitionFcn(x(k-1), w(k-1))
        %       x(k) = StateTransitionFcn(x(k-1), w(k-1), parameters)
        %   where:
        %       x(k) is the (estimated) state at time k.
        %       w(k) is the process noise at time k.
        %       'parameters' are any additional arguments that are needed
        %       by the state transition function.
        StateTransitionFcn;
    end
    
    properties(Access=public, Dependent)
        %HasAdditiveMeasurementNoise A Boolean flag that defines whether
        %the noise affecting the measurement is additive (true) or
        %non-additive (false).
        HasAdditiveMeasurementNoise;
    end
    
    properties(Access=public)
        %MeasurementFcn A function calculating the measurement, (h).
        %   Specify the transition from state to measurement as a function
        %   that produces an N-element measurement vector for an
        %   M-element state. The function may take additional input
        %   parameters if needed, e.g., in order to specify the sensor
        %   position.
        %
        %   If HasAdditiveMeasurementNoise is true, the function should
        %   have one of the following signatures:
        %       z(k) = MeasurementFcn(x(k))
        %       z(k) = MeasurementFcn(x(k), parameters)
        %   where:
        %       x(k) is the (estimated) state at time k.
        %       z(k) is the (estimated) measurement at time k.
        %       parameters are any additional arguments that are needed by
        %       the measurement function.
        %
        %   If HasAdditiveMeasurementNoise is false, the function should
        %   have one of the following signatures:
        %       z(k) = MeasurementFcn(x(k), v(k))
        %       z(k) = MeasurementFcn(x(k), v(k), parameters)
        %   where:
        %       x(k) is the (estimated) state at time k.
        %       z(k) is the (estimated) measurement at time k.
        %       v(k) is the measurement noise at time k.
        %       parameters are any additional arguments that are needed by
        %       the measurement function.
        MeasurementFcn;
        
        %Alpha A parameter that determines the spread of the Sigma Points
        %      around the state. It is usually a small positive value.
        %
        %   Default: Alpha = 1e-3
        Alpha = 1e-3;
        
        %Beta A parameter that incorporates knowledge about the distribution of
        %     the state in the generation of the sigma points. For Gaussian
        %     distributions, Beta = 2 is optimal.
        %
        %   Default: Beta = 2
        Beta = 2;
        
        %Kappa A secondary scaling parameter used in the generation of the
        %      sigma points and is usually set to 0.
        %
        %   Default: Kappa = 0;
        Kappa = 0;
    end
    
    %------------------------------------------------------------------------
    % Dependent properties whose values are stored in other hidden properties
    %------------------------------------------------------------------------    
    properties(Access=public, Dependent)
        %State The state (x)
        %   Specify the state as an M-element vector.
        State;
        
        %StateCovariance State estimation error covariance (P)
        %   Specify the covariance of the state estimation error as a
        %   scalar or an M-by-M matrix. M is the number of states. If you 
        %   specify it as a scalar it will be extended to an M-by-M 
        %   diagonal matrix.
        %
        %   Default: 1
        StateCovariance;
    end
    
    properties(Dependent)
        %ProcessNoise Process noise covariance (Q)
        %   If HasAdditiveProcessNoise is true: specify the covariance of
        %   process noise as a scalar or an M-by-M matrix, where M is the
        %   dimension of the State. If you specify it as a scalar it will
        %   be extended to an M-by-M diagonal matrix.
        %
        %   If HasAdditiveProcessNoise is false: specify the covariance of
        %   process noise as a W-by-W matrix, where W is the number of the
        %   process noise terms. In this case, ProcessNoise must be
        %   specified before the first call to the predict method. After
        %   the first assignment, you can specify it also as a scalar which
        %   will be extended to a W-by-W matrix.
        %
        %   Default: 1
        ProcessNoise;
        %MeasurementNoise Measurement noise covariance (R)
        %   If HasAdditiveMeasurementNoise is true: specify the covariance
        %   of measurement noise as a scalar or an N-by-N matrix, where N
        %   is the dimension of the measurements. If you specify it as a
        %   scalar it will be extended to an N-by-N diagonal matrix.
        %
        %   If HasAdditiveMeasurementNoise is false: specify the covariance
        %   of the measurement noise as a V-by-V matrix, where V is the
        %   number of the measurement noise terms. In this case,
        %   MeasurementNoise must be specified before the first call to the
        %   correct method. After the first assignment, you can specify it
        %   also as a scalar which will be extended to a V-by-V matrix.
        %
        %   Default: 1
        MeasurementNoise;
    end
    
    %------------------------------------------------------------------------
    % Hidden properties used by the object
    %------------------------------------------------------------------------
    properties(Access=protected)
        pM; % Length of state
        pN; % Length of measurement
        pW; % Length of process noise
        pV; % Length of measurement noise
        pState;
        pStateCovariance;
        pStateCovarianceScalar;
        pProcessNoise;
        pProcessNoiseScalar;
        pMeasurementNoise;
        pMeasurementNoiseScalar;
        pHasPrediction = false();
        pIsValidStateTransitionFcn = false(); % False until validation
        pIsValidMeasurementFcn = false(); % False until validation
        pIsStateColumnVector = true();
        pPredictor;
        pCorrector;
        pDataType;
        pIsFirstCallPredict = true(); % false after calling predict once
        pIsFirstCallCorrect = true(); % false after calling correct once        
    end
    
    %------------------------------------------------------------------------
    % Constant properties which store the default values
    %------------------------------------------------------------------------
    properties(Hidden, Constant=true, GetAccess=public) %Provide access to test cases
        constAlpha                          = 1e-3;
        constBeta                           = 2;
        constKappa                          = 0;
        constStateCovariance                = 1;
        constProcessNoise                   = 1;
        constMeasurementNoise               = 1;
        constHasAdditiveMeasurementNoise    = true;
        constHasAdditiveProcessNoise        = true;
        constDataType                       = 'double';
    end
    
    methods
        %----------------------------------------------------------------------
        % Constructor
        %----------------------------------------------------------------------
        function obj = UKF(varargin)
        %
        
        % Leave the above row empty to suppress the message: "Help for X is
        % inherited from superclass matlabshared.tracking.internal.UnscentedKalmanFilter"
        
            % The object can be constructed with either 0, 2 or 3 inputs
            % before the first Name-Value pair. Therefore, the constructor
            % should fail if the first Name-Value pair is in place 2 (after
            % one input) or more than 4 (after more than 3 inputs).
            firstNVIndex = matlabshared.tracking.internal.findFirstNVPair(varargin{:});
            
            coder.internal.errorIf(firstNVIndex==2 || firstNVIndex>4, ...
                'shared_tracking:UnscentedKalmanFilter:invalidInputsToConstructor', firstNVIndex-1);
            
            % Parse the inputs.
            if isempty(coder.target)  % Simulation
                [stateTransitionFcn, measurementFcn, state, stateCovariance, ...
                    processNoise, measurementNoise, Alpha, Beta, Kappa, ...
                    hasAdditiveProcessNoise, hasAdditiveMeasurementNoise, dataType] ...
                    = parseInputsSimulation(obj, varargin{:});
            else                      % Code generation
                [stateTransitionFcn, measurementFcn, state, stateCovariance, ...
                    processNoise, measurementNoise, Alpha, Beta, Kappa, ...
                    hasAdditiveProcessNoise, hasAdditiveMeasurementNoise, dataType] ...
                    = parseInputsCodegen(obj, varargin{:});
            end

            % Set the HasAdditiveProcessNoise and
            % HasAdditiveMeasurementNoise properties before all else. These
            % are non-tunable, and needed for correct setting of the
            % remaining of the properties.
            %
            % For codegen support, these must be set during construction.
            % They cannot be changed later.
            obj.HasAdditiveProcessNoise = hasAdditiveProcessNoise;
            obj.HasAdditiveMeasurementNoise = hasAdditiveMeasurementNoise;
            
            % Data type is determined by the state property. Rules for data
            % classes.
            % * All of the properties can be either double or single.
            %   Mixture of double and single is allowed on constructor
            %   call, but all the values will be converted to the class of
            %   the state.
            % * All of the inputs, including z, z_matrix, and u, can be
            %   double, single, or integer.
            % * The outputs have the same class as state.
            if ~isempty(state)
                classToUse = class(state);
            elseif ~isempty(dataType)
                classToUse = dataType;
            else
                classToUse = obj.constDataType;
            end
            obj.pDataType = classToUse;
            
            % Process the state and state covariance
            if ~isempty(state)
                % Set state first so that filter knows state dimensions
                obj.State = cast(state, classToUse);
            end
            
            obj.pStateCovarianceScalar = cast(obj.constStateCovariance, classToUse);
            if ~isempty(stateCovariance)
                % Validation and scalar expansion in set.X
                obj.StateCovariance = cast(stateCovariance, classToUse);
            elseif coder.internal.is_defined(obj.pM)
                % User did not provide P, but we know the state dims M. 
                % Make the default assignment
                obj.StateCovariance = cast(obj.constStateCovariance, classToUse);
            end
                        
            % Copy StateTransitionFcn and MeasurementFcn. The validation is
            % done on set.X
            %
            % Do not initialize the properties for code generation, since
            % function handles can only be assigned once.
            if ~isempty(stateTransitionFcn)
                obj.StateTransitionFcn = stateTransitionFcn;
            end
            if ~isempty(measurementFcn)
                obj.MeasurementFcn     = measurementFcn;
            end

            % Since there is no way of validating the function handles
            % before the first call that uses them, keep their IsValid
            % state as false.
            obj.pIsValidMeasurementFcn = false;
            obj.pIsValidStateTransitionFcn = false;
            
            % Validate and copy the Unscented Transformation parameters:
            % Alpha, Beta and Kappa. Validation is done in the set method.
            obj.Alpha = cast(Alpha, classToUse);
            obj.Beta  = cast(Beta, classToUse);
            obj.Kappa = cast(Kappa, classToUse);
            
            % Set the ProcessNoise. The validations and scalar expansion
            % (if needed) are in the set.ProcessNoise
            %
            % pProcessNoiseScalar: See notes for pMeasurementNoiseScalar below 
            obj.pProcessNoiseScalar = cast(obj.constProcessNoise, classToUse);
            if ~isempty(processNoise)
                obj.ProcessNoise = cast(processNoise, classToUse);
            elseif coder.internal.is_defined(obj.pW)
                % User did not provide Q, but we know the noise dims W. 
                % Make the default assignment.
                obj.ProcessNoise = cast(obj.constProcessNoise, classToUse);                
            end
            
            % Set the MeasurementNoise. The validations and scalar expansion
            % (if needed) are in set.MeasurementNoise
            %
            % Always set pMeasurementNoiseScalar: For additive noise, when
            % the measurement dimensions are known and user didn't set
            % MeasurementNoise, this is scalar expanded in correct() or
            % distance(). Set it to the default value. If the user provided
            % another scalar value, this is overwritten in
            % set.MeasurementNoise.
            %
            % Assign MeasurementNoise only if user provided it. Otherwise
            % we don't know its dimensions. For codegen support we must
            % make the assignment only when the dimensions are known
            obj.pMeasurementNoiseScalar = cast(obj.constMeasurementNoise, classToUse);
            if ~isempty(measurementNoise)
                obj.MeasurementNoise = cast(measurementNoise, classToUse);
            elseif coder.internal.is_defined(obj.pV)
                % User did not provide R, but we know the noise dims V. 
                % Make the default assignment.
                obj.MeasurementNoise = cast(obj.constMeasurementNoise, classToUse);              
            end
            
            % Keeps track of prediction state
            obj.pHasPrediction = false;
        end
        
        %----------------------------------------------------------------------
        % Predict method
        %----------------------------------------------------------------------
        function [x_pred, P_pred] = predict(obj, varargin)
            % predict Predicts the state and state estimation error covariance
            %   [x_pred, P_pred] = predict(obj) returns x_pred, the
            %   prediction of the state, and P_pred, the prediction of the
            %   state estimation error covariance at the next time step.
            %   The internal state and covariance of the unscented Kalman
            %   filter are overwritten by the prediction results.
            %
            %   [x_pred, P_pred] = predict(obj, varargin) additionally,
            %   lets you specify any input arguments that will be passed to
            %   the StateTransitionFcn.
            
            % correct must be called with a single object
            coder.internal.errorIf(numel(obj) > 1, ...
                'shared_tracking:UnscentedKalmanFilter:NonScalarFilter', ...
                'unscented Kalman filter', 'predict');
            
            % Ensure that the dimensions of x, P, Q are known, and the
            % corresponding protected properties are defined
            if isempty(coder.target)
                if obj.pIsFirstCallPredict
                    % We are in MATLAB, and this is the first call. This path
                    % is visited only once
                    ensureStateAndStateCovarianceIsDefined(obj);
                    ensureProcessNoiseIsDefined(obj);
                    obj.pIsFirstCallPredict = false();
                end
            else
                % Generating code. Definition of properties cannot be code
                % path dependent. isempty(coder.target) constant folds, but
                % we cannot check pIsFirstCallPredict. This path is visited
                % with every correct, but Coder should eliminate most, if
                % not all, unnecessary code
                ensureStateAndStateCovarianceIsDefined(obj);
                ensureProcessNoiseIsDefined(obj);
                obj.pIsFirstCallPredict = false();
            end
            
            % Validate StateTransitionFcn
            % 1) Must be defined
            % 2) Number of inputs must match the expected value
            % 3) Must return data of pState's class, and dimensions of
            % State is as expected
            %
            % 1)
            if ~obj.pIsValidStateTransitionFcn
                coder.internal.errorIf(isempty(obj.StateTransitionFcn),...
                    'shared_tracking:UnscentedKalmanFilter:undefinedStateTransitionFcn');
            end
            % 2)
            narginExpected = obj.pPredictor.getExpectedNargin(nargin);
            narginActual = nargin(obj.StateTransitionFcn);
            coder.internal.errorIf(narginActual ~= narginExpected && ...
                narginActual >= 0, ... %negative if varies
                'shared_tracking:UnscentedKalmanFilter:invalidNumInputsToPredict',...
                'StateTransitionFcn');
            % 3)
            if ~obj.pIsValidStateTransitionFcn
                coder.internal.errorIf(...
                    obj.pPredictor.validateStateTransitionFcn(obj.StateTransitionFcn,obj.pState,obj.pW,varargin{:}),...
                    'shared_tracking:UnscentedKalmanFilter:StateNonMatchingSizeOrClass',...
                    'StateTransitionFcn', 'State');
                obj.pIsValidStateTransitionFcn = true;
            end
            
            % Perform the UKF prediction
            %=== This block of code is because coder cannot handle varargin ===%
            params = cell(1, numel(varargin));
            for i=1:numel(varargin)
                params{i} = varargin{i};
            end
            [obj.pState, obj.pStateCovariance] = ...
                obj.pPredictor.predict(...
                obj.pProcessNoise, ...
                obj.pState, ...
                obj.pStateCovariance, ...
                obj.Alpha, ...
                obj.Beta, ...
                obj.Kappa, ...
                obj.StateTransitionFcn, ...
                params);
            obj.pHasPrediction = true;
            
            % obj.State outputs the estimated state in the orientation of
            % initial state provided by the user
            if nargout
                x_pred = obj.State;
                if nargout > 1
                    P_pred = obj.StateCovariance;
                end
            end
        end
        
        %----------------------------------------------------------------------
        % Correct method
        %----------------------------------------------------------------------
        function [x_corr, P_corr] = correct(obj, z, varargin)
            % correct Corrects the state and state estimation error covariance
            %   [x_corr, P_corr] = correct(obj, z) returns x_corr, the
            %   correction of the state, and P_corr, the correction of the
            %   state estimation error covariance based on the current
            %   measurement z, an N-element vector. The internal state and
            %   covariance of the unscented Kalman filter are overwritten
            %   by the corrected values.
            %
            %   [x_corr, P_corr] = correct(obj, z, varargin) additionally
            %   allows you to specify any additional arguments required by
            %   MeasurementFcn to produce a measurement.
            
            % correct must be called with a single object
            coder.internal.errorIf(numel(obj) > 1, ...
                'shared_tracking:UnscentedKalmanFilter:NonScalarFilter', ...
                'unscented Kalman filter', 'correct');
            
            % Input z_input can be a row vector or a column vector.
            % Internally, it is always a column vector.
            zcol = z(:);
            % Set the measurement dimensions with the first correct
            if ~coder.internal.is_defined(obj.pN)
                obj.pN = numel(zcol);
            end
            matlabshared.tracking.internal.validateInputSizeAndType...
                ('z', zcol, obj.pN, 'UnscentedKalmanFilter');
           
            % MeasurementFcn and related properties' validation: They are
            % performed only once, or when necessary. This is ensured in
            % the methods.
            %
            % Ensure that the dimensions of x, P, R are known, and the
            % corresponding protected properties are defined
            validateMeasurementRelatedProperties(obj);
            % Validate MeasurementFcn
            validateMeasurementFcn(obj,zcol,obj.pCorrector.getExpectedNargin(nargin),varargin{:});
            
            %=== This block of code is because coder cannot handle varargin ===%
            params = cell(1, numel(varargin));
            for i=1:numel(varargin)
                params{i} = varargin{i};
            end
            %=== ---------------------------------------------------------- ===%
            [obj.pState, obj.pStateCovariance] = ...
                obj.pCorrector.correct(...
                zcol, ...
                obj.pMeasurementNoise, ...
                obj.pState, ...
                obj.pStateCovariance, ...
                obj.Alpha, ...
                obj.Beta, ...
                obj.Kappa, ...
                obj.MeasurementFcn, ...
                params);
            
            obj.pHasPrediction = false;
            
            % obj.State outputs the estimated state in the orientation of
            % initial state provided by the user
            if nargout
                x_corr = obj.State;
                if nargout > 1
                    P_corr = obj.StateCovariance;
                end
            end
        end
        
        function newUKF = clone(UKF)
            % clone Create a copy of the filter
            %
            % newUKF = clone(UKF)
            
            % Make sure that the method was called with a single object
            cond = (numel(UKF) > 1);
            coder.internal.errorIf(cond, ...
                'shared_tracking:UnscentedKalmanFilter:NonScalarFilter', ...
                'unscented Kalman filter', 'clone');
            
            coder.inline('never');
            
            % Use str2func to get the correct object type. When called from
            % a subclass, the resulting object will be of the same subclass
            obj = str2func(coder.const(class(UKF)));
            % Construct the basic filter. The properties assigned here are:
            % * pDataType: Guaranteed to be defined (after construction). It
            % must be set immediately as it impacts the types of default
            % floating point assignments in the constructor.
            % * HasAdditiveProcessNoise, HasAdditiveProcessNoise: These set
            % pPredictor, pCorrector which must be set before other
            % properties
            newUKF = obj(...
                'HasAdditiveProcessNoise', UKF.HasAdditiveProcessNoise,...
                'HasAdditiveMeasurementNoise', UKF.HasAdditiveMeasurementNoise,...
                'DataType', UKF.pDataType);
            % Copy all protected/private properties
            %
            % ppProperties holds the list of all private/protected that may
            % not be set during construction
            ppProperties = coder.const({'pM','pN','pW','pV',...
                'pState', 'pIsStateColumnVector',...
                'StateTransitionFcn','MeasurementFcn',...
                'pStateCovariance','pStateCovarianceScalar',...
                'pProcessNoise','pProcessNoiseScalar',...
                'pMeasurementNoise','pMeasurementNoiseScalar',...
                'pHasPrediction',...
                'pIsValidStateTransitionFcn','pIsValidMeasurementFcn',...
                'Alpha','Beta','Kappa',...
                'pIsFirstCallPredict','pIsFirstCallCorrect'});
            for kk = coder.unroll(1:numel(ppProperties))
                % Copy only if the prop was set in the source obj
                if coder.internal.is_defined(UKF.(ppProperties{kk}))
                    newUKF.(ppProperties{kk}) = UKF.(ppProperties{kk});
                end
            end
        end
    end
    
    methods
        %----------------------------------------------------------------------
        function set.State(obj, value)
            validateattributes(value, ...
                {obj.pDataType}, {'real', 'finite', 'nonsparse', 'vector'},...
                'UnscentedKalmanFilter', 'State');
            % Validate dimensions only when it is known
            if coder.internal.is_defined(obj.pM)
                coder.internal.assert(isscalar(value) || numel(value)==obj.pM, ...
                    'shared_tracking:UnscentedKalmanFilter:invalidStateDims', obj.pM); 
            end
            
            % * The first assignment sets the state dimension M
            % * Scalar expand when we know M
            if isscalar(value) && coder.internal.is_defined(obj.pM)
                obj.pState = matlabshared.tracking.internal.expandScalarValue...
                    (value, [obj.pM, 1]);
            else
                obj.pState = value(:);
                obj.pM = numel(value);
                % Store the state orientation. Filter will output states in
                % the same orientation
                if iscolumn(value)
                    obj.pIsStateColumnVector = true();
                else
                    obj.pIsStateColumnVector = false();
                end
            end
        end
        
        %----------------------------------------------------------------------
        function value = get.State(obj)
            % Show a clear error message if pState is empty and we are
            % doing codegen.
            %
            % In MATLAB we can display []
            coder.internal.assert(isempty(coder.target) || coder.internal.is_defined(obj.pState),...
                'shared_tracking:UnscentedKalmanFilter:getUndefinedState');

            if obj.pIsStateColumnVector % User expects state to be a column vector
                value = obj.pState;
            else % User expetcs state to be a row vector
                value = obj.pState.';
            end
        end
        
        %----------------------------------------------------------------------
        function set.StateCovariance(obj, value)
            % Validating that the new state covariance has the correct
            % attributes and dimensions
            validateattributes(value, ...
                {obj.pDataType}, ...
                {'real', 'finite', 'nonsparse', '2d', 'nonempty', 'square'},...
                'UnscentedKalmanFilter', 'StateCovariance');
            % Check dims only if # of states is known
            if coder.internal.is_defined(obj.pM)
                matlabshared.tracking.internal.validateDataDims...
                    ('StateCovariance', value, [obj.pM, obj.pM]);
            end
            matlabshared.tracking.internal.isSymmetricPositiveSemiDefinite...
                ('StateCovariance', value);            
            
            % * The first assignment, if not scalar, sets state dimension M
            % * Perform scalar expansion if we know M.
            % * If specified as a scalar, and M is unknown, we store the
            % value separately. This is scalar expanded when user calls
            % predict/correct/distance, if M is known at that point. If M
            % is unknown then we throw an error.
            if isscalar(value)
                % Scalar. Expand only if we know the # of states
                if coder.internal.is_defined(obj.pM)
                    obj.pStateCovariance = zeros(obj.pM,obj.pM,obj.pDataType);
                    for idx = 1:obj.pM
                        obj.pStateCovariance(idx, idx) = value(1);
                    end
                else
                    % Unsure about the dimensions. Store the scalar. The
                    % first call to predict will scalar expand after
                    % enforcing state itself to be defined.
                    obj.pStateCovarianceScalar = value(1);
                end
            else
                obj.pStateCovariance = value;
                obj.pM = size(value,1);
            end
        end
        
        %----------------------------------------------------------------------
        function value = get.StateCovariance(obj)
            % Show a clear error message if pStateCovariance is empty and
            % we are doing codegen.
            %
            % In MATLAB we can display pStateCovarianceScalar, which is
            % either the default value in constStateCovariance, or a user
            % assigned scalar value
            coder.internal.assert(isempty(coder.target) || coder.internal.is_defined(obj.pStateCovariance),...
                'shared_tracking:UnscentedKalmanFilter:getUndefinedStateCovariance');
            
            if coder.internal.is_defined(obj.pStateCovariance)
                % In codegen this is the only reachable branch. This is to
                % ensure fcn returns value of the same dims in all branches
                value = obj.pStateCovariance;
            else
                value = obj.pStateCovarianceScalar;
            end
        end
        
        %----------------------------------------------------------------------
        function set.ProcessNoise(obj, value)
            validateattributes(value, ...
                {obj.pDataType}, ...
                {'real', 'finite', 'nonsparse', '2d', 'nonempty','square'},...
                'UnscentedKalmanFilter', 'ProcessNoise');
            if coder.internal.is_defined(obj.pW)
                matlabshared.tracking.internal.validateDataDims('ProcessNoise', value, [obj.pW obj.pW]);
            end
            matlabshared.tracking.internal.isSymmetricPositiveSemiDefinite('ProcessNoise', value);
            
            % The assignment sets the process noise dimensions directly if:
            % * There is non-additive process noise, and this is the first
            % assignment of Q
            % * The provided Q is not scalar
            if (~obj.HasAdditiveProcessNoise && ~coder.internal.is_defined(obj.pW)) || ~isscalar(value)
                obj.pProcessNoise = value;
                obj.pW = size(value,1);
            else
                % Scalar. Expand only if we know the # of proc noise terms
                if coder.internal.is_defined(obj.pW)
                    obj.pProcessNoise = zeros(obj.pW,obj.pW,obj.pDataType);
                    for idx = 1:obj.pW
                        obj.pProcessNoise(idx, idx) = value(1);
                    end
                else
                    % Unsure about the dimensions. Store the scalar. The
                    % first call to predict must set pProcessNoise
                    obj.pProcessNoiseScalar = value(1);
                end
            end
        end
        
        %----------------------------------------------------------------------
        function value = get.ProcessNoise(obj)
            % If doing codegen, pProcessNoise must be set before user
            % tries to get its value.
            %
            % In MATLAB we can display pProcessNoiseScalar, which is either
            % the default value in constProcessNoise, or a user assigned
            % scalar value
            coder.internal.assert(isempty(coder.target) || coder.internal.is_defined(obj.pProcessNoise),...
                'shared_tracking:UnscentedKalmanFilter:getUndefinedProcessNoise');
            
            if coder.internal.is_defined(obj.pProcessNoise)
                % In codegen this is the only reachable branch. This is to
                % ensure fcn returns value of the same dims in all branches
                value = obj.pProcessNoise;
            else
                value = obj.pProcessNoiseScalar;
            end
        end
        
        %----------------------------------------------------------------------
        function set.MeasurementNoise(obj, value)
            validateattributes(value, ...
                {obj.pDataType}, ...
                {'real', 'finite', 'nonsparse', '2d', 'nonempty', 'square'},...
                'UnscentedKalmanFilter', 'MeasurementNoise');
            %% JESUS OROYA
            obj.pN = length(value(:,1));
            %
            matlabshared.tracking.internal.validateDataAttributes('MeasurementNoise', value);
            %Every time the measurement function changes, this size may change so no size checking
            if obj.pIsValidMeasurementFcn && coder.internal.is_defined(obj.pV)
                % Skipping this check when meas. fcn is not valid allows
                % users to change the dimensions of R when they change the
                % meas. fcn (not supported in codegen)
                matlabshared.tracking.internal.validateDataDims('MeasurementNoise', value, [obj.pV obj.pV]);
            end
            matlabshared.tracking.internal.isSymmetricPositiveSemiDefinite('MeasurementNoise', value);
            
            % The assignment sets the measurement dimensions directly if:
            % * There is non-additive measurement noise, and this is the
            % first assignment of R
            % * The provided R is not scalar
            if (~obj.HasAdditiveMeasurementNoise && ~coder.internal.is_defined(obj.pV)) || ~isscalar(value)
                obj.pMeasurementNoise = value;
                obj.pV = size(value,1);
            else
                % Scalar. Expand only if we know the # of meas noise terms
                if coder.internal.is_defined(obj.pV)
                    obj.pMeasurementNoise = zeros(obj.pV,obj.pV,obj.pDataType);
                    for idx = 1:obj.pV
                        obj.pMeasurementNoise(idx, idx) = value(1);
                    end
                else
                    % Unsure about the dimensions. Store the scalar. The
                    % first call to correct/distance must set pMeasurementNoise
                    obj.pMeasurementNoiseScalar = value(1);
                end
            end
        end
        
        %----------------------------------------------------------------------
        function value = get.MeasurementNoise(obj)
            % If doing codegen, pMeasurementNoise must be set before user
            % tries to get its value.
            %
            % In MATLAB we can display pMeasurementNoiseScalar, which is
            % either the default value in constMeasurementNoise, or a user
            % assigned scalar value
            coder.internal.assert(isempty(coder.target) || coder.internal.is_defined(obj.pMeasurementNoise),...
                'shared_tracking:UnscentedKalmanFilter:getUndefinedMeasurementNoise');
            if coder.internal.is_defined(obj.pMeasurementNoise)
                % In codegen this is the only reachable branch. This is to
                % ensure fcn returns value of the same dims in all branches
                value = obj.pMeasurementNoise;
            else
                value = obj.pMeasurementNoiseScalar;
            end
        end
        
        %----------------------------------------------------------------------
        function set.StateTransitionFcn(obj, value)
            validateattributes(value, {'function_handle'},...
                {'nonempty'}, 'UnscentedKalmanFilter', 'StateTransitionFcn');
            obj.pIsValidStateTransitionFcn = false;
            obj.StateTransitionFcn = value;
        end
        
        %----------------------------------------------------------------------
        function set.MeasurementFcn(obj, value)
            validateattributes(value, {'function_handle'}, ...
                {'nonempty'}, 'UnscentedKalmanFilter', 'measurementFcn');
            obj.pIsValidMeasurementFcn = false;
            obj.MeasurementFcn = value;
        end
        
        %----------------------------------------------------------------------
        function set.Alpha(obj, value)
            validateattributes(value, {obj.pDataType},...
                {'scalar','positive','<=',1},...
                'UnscentedKalmanFilter', 'Alpha');
            obj.Alpha = value;
        end
        
        %----------------------------------------------------------------------
        function set.Beta(obj, value)
            validateattributes(value,  {obj.pDataType},...
                {'scalar','nonnegative'}, 'UnscentedKalmanFilter', 'Beta');
            obj.Beta = value;
        end
        
        %----------------------------------------------------------------------
        function set.Kappa(obj, value)
            validateattributes(value, {obj.pDataType},...
                {'scalar','nonnegative','<=',3},...
                'UnscentedKalmanFilter', 'Kappa');
            obj.Kappa = value;
        end
        
        %----------------------------------------------------------------------
        function set.HasAdditiveProcessNoise(obj, value)
            validateattributes(value, {'numeric', 'logical'},...
                {'scalar','binary'},...
                'UnscentedKalmanFilter', 'HasAdditiveProcessNoise');
            if value
                obj.pPredictor = matlabshared.tracking.internal.UKFPredictorAdditive();
            else
                obj.pPredictor = matlabshared.tracking.internal.UKFPredictorNonAdditive();
            end
        end

        %----------------------------------------------------------------------
        function value = get.HasAdditiveProcessNoise(obj)
            value = obj.pPredictor.HasAdditiveNoise;
        end
        
        %----------------------------------------------------------------------
        function set.HasAdditiveMeasurementNoise(obj, value)
            validateattributes(value, {'numeric', 'logical'},...
                {'scalar','binary'},...
                'UnscentedKalmanFilter', 'HasAdditiveMeasurementNoise');
            if value
                obj.pCorrector = matlabshared.tracking.internal.UKFCorrectorAdditive();
            else
                obj.pCorrector = matlabshared.tracking.internal.UKFCorrectorNonAdditive();
            end
        end
        
        %----------------------------------------------------------------------
        function value = get.HasAdditiveMeasurementNoise(obj)
            value = obj.pCorrector.HasAdditiveNoise;
        end
        
        %----------------------------------------------------------------------
        function set.pM(obj,value)
            % Set the number of states in the state transition model
            obj.pM = value;
            % If the process model has additive noise, the number of
            % process noise terms pW is equal to pM
            if obj.HasAdditiveProcessNoise
                obj.pW = value;
            end
        end
        
        function set.pN(obj,value)
            % Set the number of measurements in the measurement model
            obj.pN = value;
            % If the measurement model has additive noise, the number of
            % measurement noise terms pV is equal to pN
            if obj.HasAdditiveMeasurementNoise
                obj.pV = value;
            end
        end
    end
    
    methods(Hidden)
        function setMeasurementSizes(obj, measurementSize, measurementNoiseSize)
            % Sets the sizes of the measurement (pN) and measurement noise
            % (pV). Both have to be a real, positive, integer, sclar.
            validateattributes(measurementSize, {'numeric'}, {'real', ...
                'positive', 'integer', 'scalar'}, 'UnscentedKalmanFilter');
            validateattributes(measurementNoiseSize, {'numeric'}, {'real', ...
                'positive', 'integer', 'scalar'}, 'UnscentedKalmanFilter');
            obj.pN = measurementSize;
            obj.pV = measurementNoiseSize;            
        end
        
        function setStateSizes(obj, stateSize, processNoiseSize)
            % Sets the sizes of the state (pM) and process noise
            % (pW). Both have to be a real, positive, integer, sclar.
            validateattributes(stateSize, {'numeric'}, {'real', ...
                'positive', 'integer', 'scalar'}, 'UnscentedKalmanFilter');
            validateattributes(processNoiseSize, {'numeric'}, {'real', ...
                'positive', 'integer', 'scalar'}, 'UnscentedKalmanFilter');
            obj.pM = stateSize;
            obj.pW = processNoiseSize;            
        end
    end
    
    methods(Access=private)
        %----------------------------------------------------------------------
        % Parse inputs for simulation
        %----------------------------------------------------------------------
        function [stateTransitionFcn, measurementFcn, state, stateCovariance, ...
                processNoise, measurementNoise, alpha, beta, kappa, ...
                hasAdditiveProcessNoise, hasAdditiveMeasurementNoise, dataType] ...
                = parseInputsSimulation(obj, varargin)
            
            % Instantiate an input parser
            parser = inputParser;
            parser.FunctionName = mfilename;
            
            % Specify the optional parameters. 
            %
            % Specify defaults only if they are numeric properties whose
            % dimensions are known. All other properties can only be
            % assigned once for codegen support. [] is interpreted as 'not
            % specified, skip assignment' in the constructor.
            parser.addOptional('StateTransitionFcn', []);
            parser.addOptional('MeasurementFcn',     []);
            parser.addOptional('State',              []);
            parser.addParameter('StateCovariance',   []);
            parser.addParameter('ProcessNoise',      []);
            parser.addParameter('MeasurementNoise',  []);
            parser.addParameter('Alpha',             obj.constAlpha);
            parser.addParameter('Beta',              obj.constBeta);
            parser.addParameter('Kappa',             obj.constKappa);
            parser.addParameter('HasAdditiveProcessNoise', ...
                obj.constHasAdditiveProcessNoise);
            parser.addParameter('HasAdditiveMeasurementNoise', ...
                obj.constHasAdditiveMeasurementNoise);
            parser.addParameter('DataType', obj.constDataType);            
            
            % Parse parameters
            parse(parser, varargin{:});
            r = parser.Results;
            
            stateTransitionFcn      =  r.StateTransitionFcn;
            measurementFcn          =  r.MeasurementFcn;
            state                   =  r.State;
            stateCovariance         =  r.StateCovariance;
            processNoise            =  r.ProcessNoise;
            measurementNoise        =  r.MeasurementNoise;
            alpha                   =  r.Alpha;
            beta                    =  r.Beta;
            kappa                   =  r.Kappa;
            hasAdditiveProcessNoise =  r.HasAdditiveProcessNoise;
            hasAdditiveMeasurementNoise = r.HasAdditiveMeasurementNoise;
            dataType                = r.DataType;
        end
        
        %----------------------------------------------------------------------
        % Parse inputs for code generation
        %----------------------------------------------------------------------
        function [stateTransitionFcn, measurementFcn, state, stateCovariance, ...
                processNoise, measurementNoise, alpha, beta, kappa, ...
                hasAdditiveProcessNoise, hasAdditiveMeasurementNoise, dataType] ...
                = parseInputsCodegen(obj, varargin)
            
            coder.internal.prefer_const(varargin); % Required: g1381035
            
            % Find the position of the first name-property pair, firstPNIndex
            firstNVIndex = matlabshared.tracking.internal.findFirstNVPair(varargin{:});
            
            parms = struct( ...
                'StateTransitionFcn',           uint32(0), ...
                'MeasurementFcn',               uint32(0), ...
                'State',                        uint32(0), ...   
                'StateCovariance',              uint32(0), ...
                'ProcessNoise',                 uint32(0), ...
                'MeasurementNoise',             uint32(0), ...
                'Alpha',                        uint32(0), ...
                'Beta',                         uint32(0), ...
                'Kappa',                        uint32(0), ...
                'HasAdditiveProcessNoise',      uint32(0), ...
                'HasAdditiveMeasurementNoise',  uint32(0),...
                'DataType',                     uint32(0));
            
            popt = struct( ...
                'CaseSensitivity', false, ...
                'StructExpand',    true, ...
                'PartialMatching', false);
            
            % If user specifies (StateTransitionFcn, MeasurementFcn, State)
            % both via initial 3 input arguments, and the NV-pairs, the
            % NV-pair takes over. This is the behavior in inputParser used
            % in parseInputsSimulation, MATLAB NVPair parser.
            %
            % Do the same in codegen via setting default values of
            % mentioned properties first from the optional arguments.
            % NV-pair parser overrides this, if user specifies them.
            %
            % For the remaining properties: Specify defaults only if they
            % are numeric properties whose dimensions are known. All other
            % properties can only be assigned once for codegen support. []
            % is interpreted as 'not specified, skip assignment' in the
            % constructor.
            if firstNVIndex == 1 % Can't assign function_handles on codegen
                defaultStateTransitionFcn = [];
                defaultMeasurementFcn     = [];
                defaultState              = []; %We don't know the size of the state
            elseif firstNVIndex == 3 % State may be provided as Name-value pair
                defaultStateTransitionFcn = varargin{1};
                defaultMeasurementFcn     = varargin{2};
                defaultState              = []; %We don't know the size of the state
            else % The other option is that all three required inputs are provided.
                defaultStateTransitionFcn = varargin{1};
                defaultMeasurementFcn     = varargin{2};
                defaultState              = varargin{3};
            end
            
            optarg           = eml_parse_parameter_inputs(parms, popt, ...
                varargin{firstNVIndex:end});
            stateTransitionFcn = eml_get_parameter_value(optarg.StateTransitionFcn,...
                defaultStateTransitionFcn, varargin{firstNVIndex:end});
            measurementFcn = eml_get_parameter_value(optarg.MeasurementFcn,...
                defaultMeasurementFcn, varargin{firstNVIndex:end});            
            state = eml_get_parameter_value(optarg.State,...
                defaultState, varargin{firstNVIndex:end});
            stateCovariance  = eml_get_parameter_value(optarg.StateCovariance,...
                [], varargin{firstNVIndex:end});
            processNoise     = eml_get_parameter_value(optarg.ProcessNoise,...
                [], varargin{firstNVIndex:end});
            measurementNoise = eml_get_parameter_value(optarg.MeasurementNoise,...
                [], varargin{firstNVIndex:end});
            alpha            = eml_get_parameter_value(optarg.Alpha,...
                obj.constAlpha, varargin{firstNVIndex:end});
            beta             = eml_get_parameter_value(optarg.Beta,...
                obj.constBeta, varargin{firstNVIndex:end});
            kappa            = eml_get_parameter_value(optarg.Kappa,...
                obj.constKappa, varargin{firstNVIndex:end});
            hasAdditiveProcessNoise = ...
                eml_get_parameter_value(optarg.HasAdditiveProcessNoise,...
                obj.constHasAdditiveProcessNoise, varargin{firstNVIndex:end});
            hasAdditiveMeasurementNoise = ...
                eml_get_parameter_value(optarg.HasAdditiveMeasurementNoise,...
                obj.constHasAdditiveMeasurementNoise, varargin{firstNVIndex:end});
            dataType = ...
                eml_get_parameter_value(optarg.DataType,...
                obj.constDataType, varargin{firstNVIndex:end});                
        end
    end
        
    methods (Access = protected)
        %--------------------------------------------------------------------
        % saveobj to make sure that the filter is saved correctly.
        %--------------------------------------------------------------------
        function sobj = saveobj(UKF)
            sobj = struct(...
                'HasAdditiveProcessNoise',     UKF.HasAdditiveProcessNoise, ...
                'StateTransitionFcn',          UKF.StateTransitionFcn, ...
                'HasAdditiveMeasurementNoise', UKF.HasAdditiveMeasurementNoise, ...
                'MeasurementFcn',              UKF.MeasurementFcn, ...
                'State',                       UKF.State, ...
                'StateCovariance',             UKF.StateCovariance, ...
                'ProcessNoise',                UKF.ProcessNoise, ...
                'MeasurementNoise',            UKF.MeasurementNoise, ...                
                'Alpha',                       UKF.Alpha, ...
                'Beta',                        UKF.Beta, ...
                'Kappa',                       UKF.Kappa, ...
                'pM',                          UKF.pM, ...
                'pN',                          UKF.pN, ...
                'pW',                          UKF.pW, ...
                'pV',                          UKF.pV, ...
                'pState',                      UKF.pState, ...
                'pStateCovariance',            UKF.pStateCovariance, ...
                'pStateCovarianceScalar',      UKF.pStateCovarianceScalar, ...
                'pProcessNoise',               UKF.pProcessNoise, ...
                'pProcessNoiseScalar',         UKF.pProcessNoiseScalar, ...
                'pMeasurementNoise',           UKF.pMeasurementNoise, ...
                'pMeasurementNoiseScalar',     UKF.pMeasurementNoiseScalar, ...
                'pHasPrediction',              UKF.pHasPrediction, ...
                'pIsValidStateTransitionFcn',  UKF.pIsValidStateTransitionFcn, ...
                'pIsValidMeasurementFcn',      UKF.pIsValidMeasurementFcn, ...
                'pIsStateColumnVector',        UKF.pIsStateColumnVector,...
                'pDataType',                   UKF.pDataType,...
                'pIsFirstCallPredict',         UKF.pIsFirstCallPredict,...
                'pIsFirstCallCorrect',         UKF.pIsFirstCallCorrect);
            % No need to save pPredictor and pCorrector properties. These
            % are (Static) classes with constant properties, and all
            % required information is stored in HasAdditiveProcessNoise and
            % HasAdditiveMeasurementNoise. Setting these during loadobj
            % should suffice.
        end
        
        function loadPrivateProtectedProperties(UKF,sobj)
            % Helper for loadobj. This allows subclasses to not to
            % copy/paste loading code for loading private and protected
            % properties.
            
            % Subclasses must:
            % * Construct object of the correct type
            % * Set HasAdditiveProcessNoise, HasAdditiveMeasurementNoise
            % * Set StateTransitionFcn, MeasurementFcn, State, Alpha, Beta,
            % Kappa
            % * Call this method
            
            % Protected/private properties
            UKF.pDataType                  = sobj.pDataType;
            UKF.pM                         = sobj.pM;
            UKF.pN                         = sobj.pN;
            UKF.pW                         = sobj.pW;
            UKF.pV                         = sobj.pV;
            UKF.pStateCovariance           = sobj.pStateCovariance;
            UKF.pStateCovarianceScalar     = sobj.pStateCovarianceScalar;
            UKF.pProcessNoise              = sobj.pProcessNoise;
            UKF.pProcessNoiseScalar        = sobj.pProcessNoiseScalar;
            UKF.pMeasurementNoise          = sobj.pMeasurementNoise;
            UKF.pMeasurementNoiseScalar    = sobj.pMeasurementNoiseScalar;
            UKF.pHasPrediction             = sobj.pHasPrediction;
            UKF.pIsValidStateTransitionFcn = sobj.pIsValidStateTransitionFcn;
            UKF.pIsValidMeasurementFcn     = sobj.pIsValidMeasurementFcn;
            UKF.pIsStateColumnVector       = sobj.pIsStateColumnVector;
            UKF.pIsFirstCallPredict        = sobj.pIsFirstCallPredict;
            UKF.pIsFirstCallCorrect        = sobj.pIsFirstCallCorrect;            
            % Omitted protected properties:
            % * pPredictor: Set through HasAdditiveProcessNoise
            % * pCorrector: Set through HasAdditiveMeasurementNoise
            % * pState: Set through the 3rd argument in constructor in loadobj     
        end   
        
        function ensureStateAndStateCovarianceIsDefined(obj)
            % Ensure that state dimension pM, state x, state covariance P
            % are defined before we perform a predict or correct operation.
            %
            % Perform scalar expansion if M is defined, but P do not have
            % the correct dimensions.
            
            % State must be defined by the user
            coder.internal.assert(coder.internal.is_defined(obj.pState) && ...
                coder.internal.is_defined(obj.pM),...
                'shared_tracking:UnscentedKalmanFilter:UnknownNumberOfStates');
            
            % The default, or a user provided scalar value, is stored in
            % obj.pStateCovarianceScalar. Scalar expand
            if ~coder.internal.is_defined(obj.pStateCovariance)
                obj.pStateCovariance = zeros(obj.pM,obj.pM,obj.pDataType);
                for idx = 1:obj.pM
                    % No need to cast pStateCovarianceScalar. It was casted
                    % during assignment
                    obj.pStateCovariance(idx, idx) = obj.pStateCovarianceScalar;
                end
            end
        end
        
        function ensureProcessNoiseIsDefined(obj)
            % Ensure that process noise covariance dimension pW,
            % measurement noise covariance Q are defined before we perform
            % a predict operation.
            %
            % Perform scalar expansion if pW is defined, but Q is not
            % assigned
            
            coder.internal.assert(coder.internal.is_defined(obj.pW),...
                'shared_tracking:UnscentedKalmanFilter:UnknownNumberOfProcessNoiseInputs');
            
            % Scalar expand P: The default, or a user provided scalar,
            % is stored in obj.pStateCovarianceScalar
            if ~coder.internal.is_defined(obj.pProcessNoise)
                obj.pProcessNoise = matlabshared.tracking.internal.expandScalarValue...
                    (obj.pProcessNoiseScalar, [obj.pW, obj.pW]);
            end
        end
        
        function ensureMeasurementNoiseIsDefined(obj)
            % Ensure that measurement noise covariance dimension pV,
            % measurement noise covariance R are defined before we perform
            % a correct or distance operation.
            %
            % Perform scalar expansion if pV is defined, but R is not
            % assigned
            
            coder.internal.assert(coder.internal.is_defined(obj.pV),...
                'shared_tracking:UnscentedKalmanFilter:UnknownNumberOfMeasurementNoiseInputs');
            % The default, or a user provided scalar value, is stored in
            % obj.pMeasurementNoiseScalar. Scalar expand
            if ~coder.internal.is_defined(obj.pMeasurementNoise)
                obj.pMeasurementNoise = matlabshared.tracking.internal.expandScalarValue...
                    (obj.pMeasurementNoiseScalar, [obj.pV, obj.pV]);
            end
        end
        
        function validateMeasurementFcn(obj,zcol,narginExpected,varargin)
            % Validate MeasurementFcn
            % 1) Must be defined
            % 2) Number of inputs must match the expected value
            % 3) Must return data of pState's class, and dimensions of
            % measurements is as expected
            %
            % Inputs:
            %    zcol: Measurements as a column vector
            %    narginExpected: Expected number of args in MeasurementFcn
            %    varargin: Extra input arguments to MeasurementFcn
            
            %
            % 1)
            if ~obj.pIsValidMeasurementFcn
                coder.internal.errorIf(isempty(obj.MeasurementFcn),...
                    'shared_tracking:UnscentedKalmanFilter:undefinedMeasurementFcn');    
            end
            % 2)
            narginActual = nargin(obj.MeasurementFcn);
            coder.internal.errorIf(narginActual ~= narginExpected && ...
                narginActual >= 0, ... %negative if varies
                'shared_tracking:UnscentedKalmanFilter:invalidNumInputsToCorrect',...
                'MeasurementFcn');
            % 3)
            if ~obj.pIsValidMeasurementFcn
                coder.internal.errorIf(...
                    obj.pCorrector.validateMeasurementFcn(obj.MeasurementFcn,obj.pState,zcol,obj.pV,varargin{:}),...
                    'shared_tracking:UnscentedKalmanFilter:MeasurementNonMatchingSizeOrClass',...
                    'MeasurementFcn');
                obj.pIsValidMeasurementFcn = true;
            end
        end
        
        function  validateMeasurementRelatedProperties(obj)
            % Ensure that the dimensions of x, P, R are known, and the
            % corresponding protected properties are defined
            %
            % These checks are only required the first time correct or
            % distance (defined in some subclasses) is called
            if isempty(coder.target)
                if obj.pIsFirstCallCorrect
                    % We are in MATLAB, and this is the first call. This path
                    % is visited only once
                    ensureStateAndStateCovarianceIsDefined(obj);
                    ensureMeasurementNoiseIsDefined(obj);
                    obj.pIsFirstCallCorrect = false();
                end
            else
                % Generating code. Definition of properties cannot be code
                % path dependent. isempty(coder.target) constant folds, but
                % we cannot check pIsFirstCallCorrect. This path is visited
                % with every correct, but Coder should eliminate most, if
                % not all, unnecessary code
                ensureStateAndStateCovarianceIsDefined(obj);
                ensureMeasurementNoiseIsDefined(obj);
                obj.pIsFirstCallCorrect = false();
            end
        end
    end
    
    methods (Static)
        %--------------------------------------------------------------------
        % loadobj to make sure that the filter is loaded correctly.
        % This method cannot be inherited from the superclass because the
        % correct object type (phased.UnscentedKalmanFilter) has to be
        % created. Note: the saveobj method is inherited as is from the
        % superclass.
        %--------------------------------------------------------------------
        function retUKF = loadobj(sobj)
            retUKF = matlabshared.tracking.internal.UnscentedKalmanFilter...
                (sobj.StateTransitionFcn, ...
                sobj.MeasurementFcn, ...
                sobj.State, ...
                'Alpha', sobj.Alpha, ...
                'Beta', sobj.Beta, ...
                'Kappa', sobj.Kappa, ...
                'HasAdditiveProcessNoise', sobj.HasAdditiveProcessNoise, ...
                'HasAdditiveMeasurementNoise', sobj.HasAdditiveMeasurementNoise);
            % Load protected/private properties
            loadPrivateProtectedProperties(retUKF,sobj);
        end
        
        function props = matlabCodegenNontunableProperties(~)
            % Let the coder know about non-tunable parameters so that it
            % can generate more efficient code.
            props = {'pM','pN','pW','pV',...
                'pIsStateColumnVector',...
                'HasAdditiveProcessNoise','HasAdditiveMeasurementNoise',...
                'StateTransitionFcn','MeasurementFcn',...
                'pDataType'};
            % pPredictor, pCorrector: These are non-tunable but codegen
            % does not allow specifying class-values properties as
            % nontunable
        end
    end
end