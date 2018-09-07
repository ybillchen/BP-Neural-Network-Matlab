% script 'film' is used to generate a film which shows the training process
% created by Bill

filmLength = length(x(1, :)); % number of frames

% initialize memories
M = moviein(filmLength);

% generate movie
for i = 1 : filmLength
    % plot each frame
    set(0,'defaultfigurecolor','w'); % set background color
    plot(x(:, i), y(:, i), 'LineWidth', 1); % plot training result
    title(['Training Steps: ', num2str(i * checkInterval)]);
    hold on
    plot(trainIn, trainOut, 'o', 'MarkerSize', 4, 'LineWidth', 1); % plot training set
    hold off
    axis([-0.55, 0.55, -0.2, 0.05]); % uncomment to fix the axis
    
    M(i) = getframe(gcf);
end

%uncomment to generate files
% % generate .avi file
% v = VideoWriter('film180906B.avi');
% open(v);
% writeVideo(v, M);
% close(v);
% 
% % generate .gif file
% gifName = 'gif180906B';
% for i = 1 : filmLength
%     im = frame2im(M(i)); % change each frame into image
%     [I,map]=rgb2ind(im,256);
%     
%     if i == 1
%         imwrite(I, map, gifName, 'gif', 'loopcount', inf, 'DelayTime', 0)
%     else
%         imwrite(I, map, gifName, 'gif', 'writemode', 'append', 'DelayTime', 0)
%     end
%     fprintf([num2str(i), '/', num2str(filmLength), '\n']);
% end

% uncomment to show visable movie
% movie(M, 2, 360);