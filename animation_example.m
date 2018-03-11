%%% Animated GIF example %%%

%%% Create the data you want to animate %%%
x = linspace(0, 1, 50);     
y = x.^2;

%%% Set up the figure %%%
w = 800; h = 600;                                           % Plot Dimensions
filename = 'animation.gif'                                  % filename to write to
h = figure('rend','painters','pos',[100 100 w h]); clf;     % Create the figure
set(gcf, 'Color', [1,1,1]);                                 % White backgrounds are nice
hold on

%%% Prepare Plot Handles %%%
h_X = plot([x(1)], [y(1)], 'LineWidth', 2);                 % Plot handle 
axis([min(x), max(x), min(y), max(y)]);                     % Set the axis limits so all the data shows up
xlabel ('X'); ylabel('Y'); 
h_title = title(sprintf('x = %.2f', x(1)));                 % Plot title

%%%Step through x and update animation%%%
for n = 1:numel(x);
    set(h_title,'String',  sprintf('x = %.2f',x(n)) );      % update title
    h_X.XData = [h_X.XData, x(n)];                          % update plot x and y data
    h_X.YData = [h_X.YData, y(n)];

    drawnow;                                                % draw to the screen
    frame = getframe(h);                                    % capture frame for file-writing
    im = frame2im(frame);
    [imind,cm] = rgb2ind(im,256);
    
    %%% Write the animated GIF %%%
    if n==1;
          imwrite(imind,cm,filename,'gif', 'Loopcount',inf, 'DelayTime', .05); 
    elseif (mod(n, 1))==0;
          imwrite(imind,cm,filename,'gif','WriteMode','append', 'DelayTime', .05); 
     end 
    pause(.02)
end
