%MAIN
%clc; clear all; close all;
%%Global constans
global N; %Counts of Fc for low or high filts
global points; points = 500; %Counts calulated points for filters any type
global ws;
%%Input variables
string = "low"; % low, high, stop, bandpass
typeFilter = 3;
peak_to_peak = [5 8];
%% TF
filter_calculate = 1;%TRUE = 1, FALSE = 0; 
showGraph = 1;%TRUE = 1, FALSE = 0; 
SearchPh = 0;%TRUE = 1, FALSE = 0; 
 
%% SG
if showGraph == 1
    if string == "bandpass" || string == "stop"
        ws = nchoosek((0.2:0.05:0.8),2);%from 0.2 to 0.8 with step 0.5 Count = 78;
        N = size(ws,1);
        numberGraphShow = GetStrip([0.2, 0.3],'bs');
    elseif string == "low" || string == "high"
        N = 91;
        ws = linspace(0.05,0.95,N)';
        numberGraphShow = GetStrip(0.5,'lh');% What a graph will shown; 
    else
        error("Invalid string input flag in Main(low, high, bandpass, stop)");
    end
end
%% FC
if filter_calculate == 1
    [A_Amplitude, A_Phase, A_DecimalPhase] = GetMatrix(typeFilter,peak_to_peak,string);
end
%% SP
if SearchPh == 1
    %REWRITE IT
    Pulsation = [1,2,3]; % 
    [SearchedApl, SearchedF2] = Ch1SearchPh(Pulsation,typeFilter,string);
    z = DrawPhs(SearchedApl);%
    clear Pulsation;
end
%% SG
if showGraph == 1
   %
   [AFD,aPFD,dPFD] = DrawCurrent(A_Amplitude(:,numberGraphShow),A_Phase(:,numberGraphShow),A_DecimalPhase(:,numberGraphShow),ws(numberGraphShow,:),peak_to_peak,typeFilter,string);
end
%% CLEAR
clear filter_calculate; clear showGraph; clear SearchPh; clear N; clear numberGraphShow;% clear points;