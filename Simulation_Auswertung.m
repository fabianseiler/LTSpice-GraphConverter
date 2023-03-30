clc;
clear all;

%% Presets
tlim = 180;
ticks = 30;
Variables = 5;
filename = 'Algo4_110.txt';
Names1 = ["Ain", "Bin", "Cin"];
Names2 = ["w1", "w2"];
Names = [Names1,Names2];
Subplots = 2;
SubVariables = [3,2];
%%
fclose("all");
fileID = fopen(filename);

% Initializes the Matrix for n Variables
v = zeros(1,Variables);
j=1;
tline = fgetl(fileID);
while ischar (tline) 
    dt = textscan(tline,'%s','delimiter','\t');
    tm = str2double(dt{1,1}(1));
    for i = (1:Variables)
        v(i)  = str2double(dt{1,1}(i+1));
    end
    mat(j,:) = [tm v];     
    j = j+1;       
    tline = fgetl(fileID);
end
fclose(fileID);

% Creates filtered Matrix
sizem = size(mat);
matnew = mat(2:sizem(1),:);

Colors = ["red", "blue", "green", "black", "magenta", "cyan"];
Subtitles = ["(a)","(b)","(c)","(d)","(e)" ];
% Plots for n Variables and j Subplots with k Vars per j
k = 0;
for j = (1:Subplots)
    subplot(Subplots,1,j)
    hold on;
    for i = (1:SubVariables(j))
        if(SubVariables(j)<3)
            if(i==1)
                plot(1e06*matnew(:,1),matnew(:,i+1+k),"Color",Colors(i+k),"LineStyle","-", LineWidth=3);
            else
                plot(1e06*matnew(:,1),matnew(:,i+1+k),"Color",Colors(i+k),"LineStyle","--", LineWidth=3);
            end
        else
            if (i<3)
                plot(1e06*matnew(:,1),matnew(:,i+1+k),"Color",Colors(i+k),"LineStyle","-", LineWidth=3);
            elseif(i>=3 && i<6)
                plot(1e06*matnew(:,1),matnew(:,i+1+k),"Color",Colors(i+k),"LineStyle","--",LineWidth=3);
            else
                plot(1e06*matnew(:,1),matnew(:,i+1+k),"Color",Colors(i+k),"LineStyle","-.",LineWidth=3);
            end
        end
    end
    k = k+SubVariables(1);

    %Configure Plot
    if(j==1)
        title("State Variables")
        legend(Names1);
    end
    if(j==Subplots)
        xlabel("Time in \mus")
        if(j~=1)
            legend(Names2);
        end
    end
    
    xlim([0 tlim])
    xticks([0:ticks:tlim])
    ylim([0 1])
    yticks([0,0.5,1])
    pbaspect([10 2/Subplots 1])
    grid on;
end

fig=gcf;
fig.Position(3:4)=[1500,300];
hold off;

