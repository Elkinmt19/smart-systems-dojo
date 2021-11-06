% FUNCTION TO MODIFY AN EXISTING STANDARD FIGURE AND MAKE IT PRETTY
% Santiago Garcia Arango
%-----------------------------------------------------------------------------------------
% How to use this amazing function by Santi?
% When plotting a graph with commands such as "step()", "bode()", "plot()",
% we can call this function to modify the output of the graph and make it
% prettier automatically. The graph changes in the following conditions:
% colors, dimensions, title, size, linewidth.
% Tip: to close all figures, type in terminal: "close all"

% Parameters:
% graphName --> Add the graph name to show it in the graph title
% graphType --> Add the associated string to the graphType:
%                Example: "step", "bode", "" (for plots)
%-----------------------------------------------------------------------------------------

function [] = prettygraph(graphName, graphType )

% Check the users's inputs (and add the "default" values otherwise)
switch nargin
    case (0)
        graphName = "";
        graphType = "";
    case (1)
        graphType = "";
end

% Add title to the plot
title(graphName);

% Add grid to the plot
grid on

% Create "Current Figure Handler" to modify figure conditions
fig = gcf;

% Change figure color (in this case, blue)
fig.Color = [0.2 1 1];

% Add name to the plot (the one in the MATLAB window)
fig.Name = graphName;

% Create "Current Axis Handler", to edit axis conditions
ax = gca;

% Change axis font sizes
ax.FontSize = 11;

% Based on the figure type, we change the linewidths
if (graphType=="bode")
    set(findall(gcf,'type','line'),'linewidth',2)
elseif (graphType=="step")
    % Search lines of the figure to access their linewidths
    hline=findobj(fig,'Type','line','Tag','Curves');
    hline(1).LineWidth = 2;
end

% Reshape the figure and change its position
set(gcf,'Position',[10 250 500 320])

% % Remove toolbar and menubar from all figures
set(gcf, 'ToolBar', 'none');
set(gcf, 'MenuBar', 'none');

% Add hold on automatically to be able to add show multiple figures
hold on
