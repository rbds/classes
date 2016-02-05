function rlocus_tool()

% rlocus_tool
%
% Interactive root locus plotting tool
%
% Written by Adam Wickenheiser
%

clc;
close all;

% display figure
temp = get(0,'ScreenSize');
fig_width = 1152;
fig_height = 720;
h_fig = figure('Units','pixels','Position',[.5*(temp(3)-fig_width) .5*(temp(4)-fig_height) fig_width fig_height],'Resize','off',...
               'NumberTitle','off','Name','Root Locus Tool','CloseRequestFcn',@close_rlocus_tool,'ToolBar','figure');

% display axes
h_rl_ax = axes('Position',[.05 .48 .6 .5]);		% handle to root locus axis
h_resp_ax = axes('Position',[.05 .05 .6 .35]);	% handle to response axis
h_rl_copy_button = uicontrol('Style','pushbutton','String','Duplicate plot','Units','normalized','Position',[.55 .96 .1 .03],...
	                         'HorizontalAlignment','center','Callback',@rl_copy_button_cb);
h_resp_copy_button = uicontrol('Style','pushbutton','String','Duplicate plot','Units','normalized','Position',[.55 .405 .1 .03],...
	                           'HorizontalAlignment','center','Callback',@resp_copy_button_cb);
h_bd_ax = axes('Units','pixels','Position',[.68*fig_width .83*fig_height 362 95]);		% position of block diagram image
bd_img = imread('block diagram.jpg');
image(bd_img,'Parent',h_bd_ax);
set(h_bd_ax,'Visible','off');

% set up G(s) block
uipanel('Title','G(s)','FontSize',8,'Position',[.675 .70 .32 .125],'BackgroundColor',get(h_fig,'Color'));
uicontrol('Style','text','String','num:','Units','normalized','Position',[.68 .78 .04 .02],...
	      'HorizontalAlignment','left','BackgroundColor',get(h_fig,'Color'));
uicontrol('Style','text','String','den:','Units','normalized','Position',[.68 .76 .04 .02],...
	      'HorizontalAlignment','left','BackgroundColor',get(h_fig,'Color'));
h_edit_Gnum = uicontrol('Style','edit','Units','normalized','Position',[.70 .78 .05 .02],'HorizontalAlignment','left',...
                     'Callback',@tf_edit_cb,'String','[1]');
h_edit_Gden = uicontrol('Style','edit','Units','normalized','Position',[.70 .76 .05 .02],'HorizontalAlignment','left',...
                     'Callback',@tf_edit_cb,'String','[1 2]');
G_latex = annotation('textbox','String','$G(s)={1\over s+2}$','Units','normalized','Position',[.75 .75 .26 .05],'Interpreter','latex',...
	                 'BackgroundColor',get(h_fig,'Color'),'FontSize',16,'LineStyle','none','VerticalAlignment','middle','FitBoxToText','on');
G_zeros = annotation('textbox','String','zeros: none','Units','normalized','Position',[.68 .73 .04 .02],'Interpreter','tex','HorizontalAlignment','left',...
	                 'BackgroundColor',get(h_fig,'Color'),'FontSize',8,'LineStyle','none','VerticalAlignment','middle','FitBoxToText','on','Margin',0);
G_poles = annotation('textbox','String','poles: -2','Units','normalized','Position',[.68 .71 .04 .02],'Interpreter','tex','HorizontalAlignment','left',...
	                 'BackgroundColor',get(h_fig,'Color'),'FontSize',8,'LineStyle','none','VerticalAlignment','middle','FitBoxToText','on','Margin',0);
				 
% set up H(s) block
uipanel('Title','H(s)','FontSize',8,'Position',[.675 .57 .32 .125],'BackgroundColor',get(h_fig,'Color'));
uicontrol('Style','text','String','num:','Units','normalized','Position',[.68 .65 .04 .02],...
	      'HorizontalAlignment','left','BackgroundColor',get(h_fig,'Color'));
uicontrol('Style','text','String','den:','Units','normalized','Position',[.68 .63 .04 .02],...
	      'HorizontalAlignment','left','BackgroundColor',get(h_fig,'Color'));
h_edit_Hnum = uicontrol('Style','edit','Units','normalized','Position',[.70 .65 .05 .02],'HorizontalAlignment','left',...
                     'Callback',@tf_edit_cb,'String','[1]');
h_edit_Hden = uicontrol('Style','edit','Units','normalized','Position',[.70 .63 .05 .02],'HorizontalAlignment','left',...
                     'Callback',@tf_edit_cb,'String','[1]');
H_latex = annotation('textbox','String','$H(s)={1\over 1}$','Units','normalized','Position',[.75 .62 .26 .05],'Interpreter','latex',...
	                 'BackgroundColor',get(h_fig,'Color'),'FontSize',16,'LineStyle','none','VerticalAlignment','middle','FitBoxToText','on');
H_zeros = annotation('textbox','String','zeros: none','Units','normalized','Position',[.68 .60 .04 .02],'Interpreter','tex','HorizontalAlignment','left',...
	                 'BackgroundColor',get(h_fig,'Color'),'FontSize',8,'LineStyle','none','VerticalAlignment','middle','FitBoxToText','on','Margin',0);
H_poles = annotation('textbox','String','poles: none','Units','normalized','Position',[.68 .58 .04 .02],'Interpreter','tex','HorizontalAlignment','left',...
	                 'BackgroundColor',get(h_fig,'Color'),'FontSize',8,'LineStyle','none','VerticalAlignment','middle','FitBoxToText','on','Margin',0);

% set up K(s) block
uipanel('Title','K(s)','FontSize',8,'Position',[.675 .44 .32 .125],'BackgroundColor',get(h_fig,'Color'));
uicontrol('Style','text','String','num:','Units','normalized','Position',[.68 .52 .04 .02],...
	      'HorizontalAlignment','left','BackgroundColor',get(h_fig,'Color'));
uicontrol('Style','text','String','den:','Units','normalized','Position',[.68 .50 .04 .02],...
	      'HorizontalAlignment','left','BackgroundColor',get(h_fig,'Color'));
h_edit_Knum = uicontrol('Style','edit','Units','normalized','Position',[.70 .52 .05 .02],'HorizontalAlignment','left',...
                     'Callback',@tf_edit_cb,'String','[1]');
h_edit_Kden = uicontrol('Style','edit','Units','normalized','Position',[.70 .50 .05 .02],'HorizontalAlignment','left',...
                     'Callback',@tf_edit_cb,'String','[1]');
K_latex = annotation('textbox','String','$K(s)={1\over 1}$','Units','normalized','Position',[.75 .49 .26 .05],'Interpreter','latex',...
	                 'BackgroundColor',get(h_fig,'Color'),'FontSize',16,'LineStyle','none','VerticalAlignment','middle','FitBoxToText','on');
K_zeros = annotation('textbox','String','zeros: none','Units','normalized','Position',[.68 .47 .04 .02],'Interpreter','tex','HorizontalAlignment','left',...
	                 'BackgroundColor',get(h_fig,'Color'),'FontSize',8,'LineStyle','none','VerticalAlignment','middle','FitBoxToText','on','Margin',0);
K_poles = annotation('textbox','String','poles: none','Units','normalized','Position',[.68 .45 .04 .02],'Interpreter','tex','HorizontalAlignment','left',...
	                 'BackgroundColor',get(h_fig,'Color'),'FontSize',8,'LineStyle','none','VerticalAlignment','middle','FitBoxToText','on','Margin',0);

% set up K(s)G(s)H(s) block
uipanel('Title','K(s)G(s)H(s)','FontSize',8,'Position',[.675 .32 .32 .115],'BackgroundColor',get(h_fig,'Color'));
KGH_latex = annotation('textbox','String','$K(s)G(s)H(s)={1\over s+2}$','Units','normalized','Position',[.678 .36 .29 .05],'Interpreter','latex',...
	                   'BackgroundColor',get(h_fig,'Color'),'FontSize',16,'LineStyle','none','VerticalAlignment','middle','FitBoxToText','on');
KGH_zeros = annotation('textbox','String','zeros: \infty','Units','normalized','Position',[.68 .35 .04 .02],'Interpreter','tex','HorizontalAlignment','left',...
	                   'BackgroundColor',get(h_fig,'Color'),'FontSize',8,'LineStyle','none','VerticalAlignment','middle','FitBoxToText','on','Margin',0);
KGH_poles = annotation('textbox','String','poles: -2','Units','normalized','Position',[.68 .33 .04 .02],'Interpreter','tex','HorizontalAlignment','left',...
	                   'BackgroundColor',get(h_fig,'Color'),'FontSize',8,'LineStyle','none','VerticalAlignment','middle','FitBoxToText','on','Margin',0);

% set up gain slider
uicontrol('Style','text','String','K =','Units','normalized','Position',[.675 .28 .04 .02],...
	      'HorizontalAlignment','left','BackgroundColor',get(h_fig,'Color'));
h_slider_edit = uicontrol('Style','edit','Units','normalized','Position',[.695 .28 .04 .02],'HorizontalAlignment','left',...
                          'Callback',@slider_edit_cb,'String','1');
h_slider_min = uicontrol('Style','text','String','0','Units','normalized','Position',[.735 .28 .02 .02],...
	                     'HorizontalAlignment','right','BackgroundColor',get(h_fig,'Color'));
h_slider = uicontrol('Style','slider','Units','normalized','Position',[.76 .275 .18 .03],'Callback',@slider_cb,'Min',-3,'Max',1,'Value',0);
h_slider_max = uicontrol('Style','text','String','10','Units','normalized','Position',[.945 .28 .04 .02],...
	                     'HorizontalAlignment','left','BackgroundColor',get(h_fig,'Color'));

% set up closed-loop poles block
uipanel('Title','Closed-loop poles','FontSize',8,'Position',[.675 .03 .12 .24],'BackgroundColor',get(h_fig,'Color'));
h_cl_poles_text = uicontrol('Style','text','String','','Units','normalized','Position',[.685 .04 .10 .21],'HorizontalAlignment','left','BackgroundColor',get(h_fig,'Color'));

% set up time response selection block
uipanel('Title','Time response','FontSize',8,'Position',[.80 .03 .16 .24],'BackgroundColor',get(h_fig,'Color'));
h_radio_imp = uicontrol('Style','radiobutton','String','impulse response','Units','normalized','Position',[.81 .22 .14 .02],'HorizontalAlignment','left',...
	                    'BackgroundColor',get(h_fig,'Color'),'Value',1,'Callback',@radio_cb);
h_radio_step = uicontrol('Style','radiobutton','String','step response','Units','normalized','Position',[.81 .19 .14 .02],'HorizontalAlignment','left',...
	                     'BackgroundColor',get(h_fig,'Color'),'Callback',@radio_cb);
h_radio_time = uicontrol('Style','radiobutton','String','r(t) =','Units','normalized','Position',[.81 .16 .14 .02],'HorizontalAlignment','left',...
	                     'BackgroundColor',get(h_fig,'Color'),'Callback',@radio_cb);
h_edit_rt = uicontrol('Style','edit','Units','normalized','Position',[.855 .158 .05 .02],'HorizontalAlignment','left','String','');
h_radio_lap = uicontrol('Style','radiobutton','String','R(s) =','Units','normalized','Position',[.81 .12 .14 .02],'HorizontalAlignment','left',...
	                    'BackgroundColor',get(h_fig,'Color'),'Callback',@radio_cb);
h_edit_Rsnum = uicontrol('Style','edit','Units','normalized','Position',[.855 .13 .05 .02],'HorizontalAlignment','left');
uicontrol('Style','text','String','num','Units','normalized','Position',[.91 .13 .04 .02],'HorizontalAlignment','left','BackgroundColor',get(h_fig,'Color'));
h_edit_Rsden = uicontrol('Style','edit','Units','normalized','Position',[.855 .105 .05 .02],'HorizontalAlignment','left');
uicontrol('Style','text','String','den','Units','normalized','Position',[.91 .105 .04 .02],'HorizontalAlignment','left','BackgroundColor',get(h_fig,'Color'));
h_resp_button = uicontrol('Style','pushbutton','String','Plot response','Units','normalized','Position',[.83 .04 .1 .05],'HorizontalAlignment','center','Callback',@resp_button_cb);

% add stats menu
stats_menu = uimenu('Label','Stats');
uimenu(stats_menu,'Label','Find Damping Ratio','Callback',@damp_rat_cb);
uimenu(stats_menu,'Label','Step Response','Callback',@step_stats_cb);
uimenu(stats_menu,'Label','Bode Plots','Callback',@bode_plots_cb);

% global variables
G_tf = tf(1,[1 2]);
H_tf = tf(1,1);
K_tf = tf(1,1);
KGH_tf = K_tf*G_tf*H_tf;
gain = 1;
h_cl_poles = [];

% trigger callback
tf_edit_cb(h_edit_Gnum,0);

% wait for user input
uiwait(h_fig);

    function tf_edit_cb(cb_handle, event)	% triggered when any transfer function num or den is changed
		
		% detect which transfer function was changed
		switch cb_handle
			case {h_edit_Gnum, h_edit_Gden}
				tf_name = 'G';
				h_latex = G_latex;
				h_num = h_edit_Gnum;
				h_den = h_edit_Gden;
				h_zeros = G_zeros;
				h_poles = G_poles;
			case {h_edit_Hnum, h_edit_Hden}
				tf_name = 'H';
				h_latex = H_latex;
				h_num = h_edit_Hnum;
				h_den = h_edit_Hden;
				h_zeros = H_zeros;
				h_poles = H_poles;
			case {h_edit_Knum, h_edit_Kden}
				tf_name = 'K';
				h_latex = K_latex;
				h_num = h_edit_Knum;
				h_den = h_edit_Kden;
				h_zeros = K_zeros;
				h_poles = K_poles;
		end
			
		% display transfer function in Latex
		num = str2num(get(h_num,'String'));
		str_num = poly2str(num,'s');
		den = str2num(get(h_den,'String'));
		str_den = poly2str(den,'s');
		set(h_latex,'FontSize',16,'String',sprintf('$%s(s)={%s\\over %s}$',tf_name,str_num,str_den));
		while true
			pos = get(h_latex,'Position');
			if pos(3) > 0.26
				fontsize = get(h_latex,'FontSize');
				set(h_latex,'FontSize',fontsize-2);
			else
				break;
			end
		end
		
		% calculate and display poles and zeros
		p = roots(num);
		if isempty(p)
			set(h_zeros,'String','zeros: none');
		else
			ss = num2str(p,3);
			str = 'zeros: ';
			for i = 1:size(ss,1)
				str = [str sprintf('%s, ',ss(i,:))];
			end
			set(h_zeros,'String',str(1:end-2));
		end
		p = roots(den);
		if isempty(p)
			set(h_poles,'String','poles: none');
		else
			ss = num2str(p,3);
			str = 'poles: ';
			for i = 1:size(ss,1)
				str = [str sprintf('%s, ',ss(i,:))];
			end
			set(h_poles,'String',str(1:end-2));
		end

		% update KGH and its zeros and poles
		G_tf = tf(str2num(get(h_edit_Gnum,'String')),str2num(get(h_edit_Gden,'String')));
		H_tf = tf(str2num(get(h_edit_Hnum,'String')),str2num(get(h_edit_Hden,'String')));
		K_tf = tf(str2num(get(h_edit_Knum,'String')),str2num(get(h_edit_Kden,'String')));
		KGH_tf = K_tf*G_tf*H_tf;
		[num,den] = tfdata(KGH_tf);
		num = num{1}; den = den{1};
		str_num = poly2str(num,'s');
		str_den = poly2str(den,'s');
		set(KGH_latex,'FontSize',16,'String',sprintf('$K(s)G(s)H(s)={%s\\over %s}$',str_num,str_den));
		while true
			pos = get(h_latex,'Position');
			if pos(3) > 0.29
				fontsize = get(h_latex,'FontSize');
				set(h_latex,'FontSize',fontsize-2);
			else
				break;
			end
		end
		p = roots(den);
		n = length(p);
		if isempty(p)
			set(h_poles,'String','poles: none');
		else
			ss = num2str(p,3);
			str = 'poles: ';
			for i = 1:size(ss,1)
				str = [str sprintf('%s, ',ss(i,:))];
			end
			set(KGH_poles,'String',str(1:end-2));
		end
		p = roots(num);
		m = length(p);
		ss = num2str(p,3);
		str = 'zeros: ';
		for i = 1:size(ss,1)
			str = [str sprintf('%s, ',ss(i,:))];
		end
		for i = 1:n-m
			str = [str '\infty, '];
		end
		set(KGH_zeros,'String',str(1:end-2));
		
		% redraw root locus
		set(h_fig,'CurrentAxes',h_rl_ax);
		rlocus(KGH_tf);
		[r,k] = rlocus(KGH_tf);
		h_cl_poles = line('XData',[],'YData',[],'Marker','o','MarkerSize',6,'MarkerFaceColor','r','LineStyle','none');
		
		% adjust slider limits
		xlims = get(h_rl_ax,'XLim');
		ylims = get(h_rl_ax,'YLim');
		axis_mag = max(abs([xlims ylims]));
		gain_mag = min(abs(r),[],1);
		ind = find(gain_mag>axis_mag,1,'first');
		if isempty(ind), ind = length(k); end
		set(h_slider_max,'String',num2str(k(ind-1)^1.25,3));
		if get(h_slider,'Value') > log10(k(ind-1)^1.25)
			set(h_slider,'Value',log10(k(ind-1)^1.25));
		end
		set(h_slider,'Max',log10(k(ind-1)^1.25));
		
		% trigger slider callback
		slider_cb(h_slider,0);		

	end

	function slider_cb(cb_handle, event)	% triggered when slider is moved
		
		% get value and set edit box
		gain = 10^get(h_slider,'Value');
		set(h_slider_edit,'String',num2str(gain,4));
		
		% plot closed-loop poles
		r = rlocus(KGH_tf,gain);
		set(h_cl_poles,'XData',real(r),'YData',imag(r));
		
		% set closed-loop poles text
		set(h_cl_poles_text,'String',num2str(r,6));
		
	end

	function slider_edit_cb(cb_handle, event)	% triggered when slider edit box is changed
		
		% if value is within limits, adjust slider; otherwise, just move slider to min or max but don't constrain gain
		gain = str2num(get(h_slider_edit,'String'));
		if gain < 10^-2
% 			gain = 10^-2;
			set(h_slider,'Value',-2);
			set(h_slider_edit,'String','0.01');
		end
		max_log_gain = get(h_slider,'Max');
		if gain > 10^max_log_gain
% 			gain = 10^max_log_gain;
			set(h_slider,'Value',max_log_gain);
			set(h_slider_edit,'String',num2str(gain,4));
		end
		
		% plot closed-loop poles
		r = rlocus(KGH_tf,gain);
		set(h_cl_poles,'XData',real(r),'YData',imag(r));
		
		% set closed-loop poles text
		set(h_cl_poles_text,'String',num2str(r,6));
		
	end
		
	function radio_cb(cb_handle, event)	% triggered when radio button is pushed
		
		set([h_radio_imp h_radio_step h_radio_time h_radio_lap],'Value',0);
		set(cb_handle,'Value',1);
		
	end

	function resp_button_cb(cb_handle, event)	% triggered when plot time response button is pushed
		
		set(h_fig,'CurrentAxes',h_resp_ax);
		ind = find(cell2mat(get([h_radio_imp h_radio_step h_radio_time h_radio_lap],'Value')));
		switch ind
			case 1	% impulse response
				impulse(feedback(gain*K_tf*G_tf,H_tf));
                
			case 2	% step response
				step(feedback(gain*K_tf*G_tf,H_tf));
                
			case 3	% reponse to r(t)
				T = 1/min(abs(get(h_cl_poles,'XData')));		% maximum time constant of closed-loop poles
				
				% compute input r(t) on [0,5*T]
				t_vec = linspace(0,6*T,1000);
				r_t = zeros(size(t_vec));
				str = get(h_edit_rt,'String');
				for i = 1:length(t_vec)
					t = t_vec(i);
					r_t(i) = eval(str);
				end
				
				% simulate response to r(t)
				lsim(feedback(gain*K_tf*G_tf,H_tf),r_t,t_vec);
				title('Response to r(t)');
                
			case 4	% response to R(s)
				num = str2num(get(h_edit_Rsnum,'String'));
				den = str2num(get(h_edit_Rsden,'String'));
				R_tf = tf(num,den);
				impulse(R_tf*feedback(gain*K_tf*G_tf,H_tf),R_tf);
				title('Response to R(s)');
		end
						
	end

	function rl_copy_button_cb(cb_handle, event)	% triggered when duplicate root locus plot button is pushed
		
		figure;
		rlocus(KGH_tf);
		
	end
	
	function resp_copy_button_cb(cb_handle, event)	% triggered when duplicate response plot button is pushed
		
		figure;
		ind = find(cell2mat(get([h_radio_imp h_radio_step h_radio_time h_radio_lap],'Value')));
		switch ind
			case 1	% impulse response
				impulse(feedback(gain*K_tf*G_tf,H_tf));
			case 2	% step response
				step(feedback(gain*K_tf*G_tf,H_tf));
			case 3	% reponse to r(t)
				T = -1/min(get(h_cl_poles,'XData'));		% maximum time constant of closed-loop poles
				
				% compute input r(t) on [0,5*T]
				t_vec = linspace(0,5*T,1000);
				r_t = zeros(size(t_vec));
				str = get(h_edit_rt,'String');
				for i = 1:length(t_vec)
					t = t_vec(i);
					r_t(i) = eval(str);
				end
				
				% simulate response to r(t)
				lsim(feedback(gain*K_tf*G_tf,H_tf),r_t,t_vec);
				title('Response to r(t)');
			case 4	% response to R(s)
				num = str2num(get(h_edit_Rsnum,'String'));
				den = str2num(get(h_edit_Rsden,'String'));
				R_tf = tf(num,den);
				impulse(R_tf*feedback(gain*K_tf*G_tf,H_tf));
				title('Response to R(s)');
		end
		
	end
	
	function damp_rat_cb(cb_handle, event)	% triggered when damping ratio stats menu item is selected
		
		% create dialog box to ask for desired damping ratio
		zeta = inputdlg('Desired damping ratio');
		zeta = str2num(zeta{1});
		
		% get roots from rlocus, find roots bounding desired damping ratio
		[r,K] = rlocus(KGH_tf);
		zetas = cos(pi-angle(r));
		ind = zeros(1,size(zetas,1));
		mag = zeros(1,size(zetas,1));
		for i = 1:size(zetas,1)		% loop through each row of zetas
			temp = find((zetas(i,1:end-1)<zeta & zetas(i,2:end)>=zeta & abs(diff(zetas(i,:))) < 1) | (zetas(i,1:end-1)>zeta & zetas(i,2:end)<=zeta & abs(diff(zetas(i,:))) < 1));
			if isempty(temp)
				ind(i) = 0;
				mag(i) = inf;
			elseif length(temp) > 1
				[v,j] = min(abs(r(i,temp)));
				ind(i) = temp(j);
				mag(i) = abs(r(i,temp(j)));
			else
				ind(i) = temp;
				mag(i) = abs(r(i,temp));
			end
		end
		
		% handle empty case
		if all(ind == 0)
			disp('No roots found with specificed damping ratio');
			return;
		end
		
		% find minimum magnitude pole that bounds desired damping ratio
		[v,j] = min(mag);
		
		% repeat for a fine grid of gains around desired damping ratio
		K = linspace(K(ind(j)),K(ind(j)+1),1000);
		r = rlocus(KGH_tf,K);
		zetas = cos(pi-angle(r));
		ind = zeros(1,size(zetas,1));
		mag = zeros(1,size(zetas,1));
		for i = 1:size(zetas,1)		% loop through each row of zetas
			temp = find((zetas(i,1:end-1)<zeta & zetas(i,2:end)>=zeta & abs(diff(zetas(i,:))) < 1) | (zetas(i,1:end-1)>zeta & zetas(i,2:end)<=zeta & abs(diff(zetas(i,:))) < 1));
			if isempty(temp)
				ind(i) = 0;
				mag(i) = inf;
			elseif length(temp) > 1
				[v,j] = min(abs(r(i,temp)));
				ind(i) = temp(j);
				mag(i) = abs(r(i,temp(j)));
			else
				ind(i) = temp;
				mag(i) = abs(r(i,temp));
			end
		end
		
		% find minimum magnitude pole that bounds desired damping ratio
		[v,j] = min(mag);
		
		% find gain corresponding to desired damping ratio using fzero
		Kstar = fzero(@loc_zeta_find,[K(ind(j)) K(ind(j)+1)]);
		
			function f = loc_zeta_find(loc_K)
				
				loc_r = rlocus(KGH_tf,loc_K);
				loc_mag = abs(loc_r);
				[v,i] = min(abs(loc_mag-mag(j)));
				f = cos(pi-angle(loc_r(i))) - zeta;
				
			end
		
		% plot zeta line
		set(h_fig,'CurrentAxes',h_rl_ax);
		sgrid(zeta,[]);
		
		% set gain to Kstar and trigger slider callback
		if get(h_slider,'Max') < log10(Kstar)
			set(h_slider,'Max',log10(Kstar));
		end
		set(h_slider,'Value',log10(Kstar));
		slider_cb(h_slider,0);
				
	end

	function step_stats_cb(cb_handle, event)	% triggered when step response stats menu item is selected
		
		% plot step response
		figure;
		step(feedback(gain*K_tf*G_tf,H_tf));
		[y,t] = step(feedback(gain*K_tf*G_tf,H_tf));
		
		% steady-state error
		e_ss = dcgain(1-feedback(gain*K_tf*G_tf,H_tf));
		str{1} = sprintf('Steady-state error = %6.4g',e_ss);
				
		% overshoot
		[max_y,ind] = max(y);
		M_p = 100*(max_y/(1-e_ss) - 1);
		if M_p < 0
			str{2} = 'Maximum overshoot = 0%';
			str{3} = 'Peak time = \infty';
		else
			str{2} = sprintf('Maximum overshoot = %6.4g%%',M_p);
			str{3} = sprintf('Peak time = %6.4g',t(ind));
			line('XData',[0 t(ind) t(ind)],'YData',[max_y max_y 0],'LineStyle','--');
		end
		
		% rise time
        ind1 = find(y >= 0.1*(1-e_ss),1,'first');
        ind2 = find(y >= 0.9*(1-e_ss),1,'first');
        str{4} = sprintf('Rise time = %6.4g',t(ind2)-t(ind1));
        line('XData',[t(ind1) t(ind1)],'YData',[0 y(ind1)],'LineStyle','--');
        line('XData',[t(ind2) t(ind2)],'YData',[0 y(ind2)],'LineStyle','--');
		
		% settling time
		ind = find(y <= 0.98*(1-e_ss) | y >= 1.02*(1-e_ss),1,'last');
		if isempty(ind)
			str{5} = 'Settling time = unknown';
		else
			str{5} = sprintf('Settling time = %6.4g',t(ind));
			line('XData',[t(ind) t(ind)],'YData',[0 y(ind)],'LineStyle','--');
			line('XData',[0 t(end)],'YData',0.98*(1-e_ss)*[1 1],'LineStyle','--');
			line('XData',[0 t(end)],'YData',1.02*(1-e_ss)*[1 1],'LineStyle','--');
		end
				
		text('Position',[.65 .15],'Units','normalized','String',str,'FontSize',8,'BackgroundColor','w','EdgeColor','k');
		
	end

	function bode_plots_cb(cb_handle, event)	% triggered when Bode plots stats menu item is selected

		% plot Bode plots
		figure;
		bode(gain*G_tf*H_tf,'k',K_tf,'k--',gain*K_tf*G_tf*H_tf,'b',feedback(gain*K_tf*G_tf,H_tf),'g');
		
	end	
	
	function close_rlocus_tool(cb_handle, event)	% when Cancel button is pressed or figure window is closed
		uiresume(h_fig);
	end

delete(h_fig);

end