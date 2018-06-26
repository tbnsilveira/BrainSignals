function plugInGUI = createGUI(this)   %#ok hSrc not used
%CreateGUI Build and cache UI plug-in for 'Load from Workspace' Source plug-in.
%   This adds the connect button and menu to the scope.
%   No install/render needs to be done here.

% Copyright 2004-2006 The MathWorks, Inc.
% $Revision: 1.1.6.2 $ $Date: 2007/06/14 05:21:30 $

plugInGUI = CreateLoadWksp(this);
this.createInfoGUI;


%% CreateLoadWksp
function plugInGUI = CreateLoadWksp(this)

% Place=1 for each of these within their respective Source groups
% Placement is just after "new"

mLoadExpr = uimgr.uimenu('LoadWkspMenu',2,'Import from &Workspace...');
mLoadExpr.WidgetProperties = {...
    'callback', @(hco,ev)LoadExprDlg(this)};

bLoadExpr = uimgr.spcpushtool('LoadWkspButton',2);
bLoadExpr.IconAppData = 'import_from_workspace';
bLoadExpr.WidgetProperties = {...
    'tooltip','Import from workspace', ...
    'click', @(hco,ev)LoadExprDlg(this)};

% Create plug-in installer
plan = {mLoadExpr,'Base/Menus/File/Sources';
        bLoadExpr,'Base/Toolbars/Main/Sources'};
plugInGUI = uimgr.uiinstaller(plan);

%%
function LoadExprDlg(this)

if isempty(this.LoadExpr)
    this.LoadExpr = scopeextensions.LoadExpr(this.Application);
end

this.importHandler = handle.listener(this.LoadExpr, ...
    'ImportBtnClicked', @(h, ev)importWkspVar(this));

this.LoadExpr.show(true);
this.LoadExpr.dialog.setFocus('pushImport');


% [EOF]
