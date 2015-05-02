function main()     % ' Parent function '
  close all
    handles=struct;    %'Structure which stores all object handles
    datas=struct;      %'Structure which stores your datas
    gui1;              % call the function to create gui1
    gui2;              % call the function to create gui2
    disp(handles)      % just to show you what handle struct contain
    function gui1  % First nested function
      handles.fig1=figure('Position',[82 363 560 420]);
      handles.edit1=uicontrol('Pos',[30 50 50 20],'Style','edit');
      handles.pushbutton1=uicontrol('Pos',[90 50 100 20],'String','Send to    GUI2');
      set(handles.pushbutton1,'Callback',@send_datas_clbk);
      end
      function gui2   % Second nested function
      handles.fig2=figure('pos',[82+700 363 560 420]);
      handles.static1=uicontrol('Style','text');
      end
% Callbacks function, that is a nested function too
      function send_datas_clbk(hObject,Event)
         datas.value1=get(handles.edit1,'String');
         set(handles.static1,'String',datas.value1);
      end
end