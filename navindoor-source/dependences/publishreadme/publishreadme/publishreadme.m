function publishreadme(name,folder, xmlflag)
%PUBLISHREADME Publish a README.m file to HTML and GitHub-flavored markdown
%
% publishreadme(folder, xmlflag)
%
% This function is designed to publish a README.m documentation and
% examples script to both HTML and GitHub-flavored markdown, making it
% easier to use a single file for GitHub and MatlabCentral File Exchange
% documentation.
%
% The markdown stylesheet can also be used independently by publish.m to
% convert any file written with Matlab markup to markdown. 
%
% Input variables:
%
%   folder:     folder name.  The folder should contain a file names
%               README.m. A README.md and README.html file will be added to
%               this folder. If necessary, a readmeExtras folder that holds
%               any supporting images will also be added.
%
%   xmlflag:    logical scalar, true to produce an XML output as well.  If not
%               included, will be false.

% Copyright 2016 Kelly Kearney

validateattributes(folder, {'char'}, {}, 'publishreadme', 'folder');

if nargin < 2
    xmlflag = false;
end

validateattributes(xmlflag, {'logical'}, {'scalar'}, 'publishreadme', 'xmlflag');

% READMEs already on the path (pretty common in external toolboxes) will
% shadow these, which prevents the target file from being published.  Make
% a copy to get around that.   

mfile = fullfile(folder, [name,'.m']);
%if ~exist(mfile, 'file')
%    error('File %s not found', mfile);
%end
tmpfile = [tempname('.') '.m'];
[~,tmpbase,~] = fileparts(tmpfile);
copyfile(mfile, tmpfile);

readmefolder = fullfile(folder, 'imgs-matlab');

% Remve old published versions

if exist(readmefolder, 'dir')
    rmdir(readmefolder, 's');
end

% Options for html and markdown publishing

htmlOpt = struct('format', 'html', ...
               'showCode', true, ...
               'outputDir', tempdir, ...
               'createThumbnail', false, ...
               'maxWidth', 800);
           
mdOpt = struct('format', 'html', ...
               'stylesheet', 'mxdom2githubmd.xsl', ...
               'showCode', true, ...
               'outputDir', readmefolder, ...
               'createThumbnail', false, ...
               'maxWidth', 1000);
           
xmlOpt = struct('format', 'xml', ...
               'showCode', true, ...
               'outputDir', readmefolder, ...
               'createThumbnail', false, ...
               'maxWidth', 800);

% Publish, and rename READMEs back to original names
           
htmlfile = publish(tmpfile, htmlOpt);
mdfile   = publish(tmpfile, mdOpt);
if xmlflag
    xmlfile  = publish(tmpfile, xmlOpt);
end

% Correct HTML in markdown (R2016b+ uses html in command window printouts)

mdtxt = fileread(mdfile);
mdtxt = strrep(mdtxt, '&times;', 'x');
mdtxt = strrep(mdtxt, '&gt;', '>');
fid = fopen(mdfile, 'wt');
fprintf(fid, '%s', mdtxt);
fclose(fid);

movefile(mdfile,   fullfile(readmefolder, [name,'.md']));
movefile(htmlfile, fullfile(readmefolder, [name,'.html']));
if xmlflag
    movefile(xmlfile,  fullfile(readmefolder, [name,'.xml']));
end

delete(tmpfile);

% Move main files up, and replace references to supporting materials

if xmlflag
    movefile(fullfile(readmefolder, [name,'.xml']), folder);
end

Files = dir(readmefolder);
fname = setdiff({Files.name}, {'.', '..', [name,'.md'], [name,'.html']});
fnamenew = strrep(fname, tmpbase, name);
if isempty(fname)
    movefile(fullfile(readmefolder, [name,'.md']), folder);
    movefile(fullfile(readmefolder, [name,'.html']), folder);
    rmdir(readmefolder, 's');
else

    % Replace a few special characters that render incorrectly in html
    
    textmd = fileread(fullfile(readmefolder, [name,'.md']));
    textmd = regexp(textmd, '\n', 'split')';
    
    texthtml = fileread(fullfile(readmefolder, [name,'.html']));
    texthtml = regexp(texthtml, '\n', 'split')';    
    
    textmd   = strrep(textmd, '&times;', 'x'); % until I figure out how to do this in the XSL file
    textmd   = strrep(textmd,   tmpbase, fullfile('.', 'imgs-matlab', name));
    texthtml = strrep(texthtml, tmpbase, fullfile('.', 'imgs-matlab', name));
    for ii = 1:length(fname)   
        movefile(fullfile(readmefolder, fname{ii}), fullfile(readmefolder, fnamenew{ii}));
    end
    fid = fopen(fullfile(folder, [name,'.md']), 'wt');
    fprintf(fid, '%s\n', textmd{:});
    fclose(fid);
    fid = fopen(fullfile(folder, [name,'.html']), 'wt');
    fprintf(fid, '%s\n', texthtml{:});
    fclose(fid);
    
    delete(fullfile(readmefolder, [name,'.md']));
    delete(fullfile(readmefolder, [name,'.html']));
    
end
