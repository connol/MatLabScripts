%++++++++++++++++++++++++++++++++++++++++++
% Educational Model of CV Virus Epidemic for BioEng 340 Class 4-17-200
%Voiland School of Chemical and Biological Engineering WSU
%by Howard Davis Ph.D. 
%++++++++++++++++++++++++++++++++++++++++++

%++++++++ How to manipulate +++++++++++++++
% Most of the virus specific parameters are found in the Virus class
% detailed in Virus.m. You can set the rest of the initial parameters in
% the global variables

Virus; %run Virus.m
Person; %run Person.m
EpiDay; %run EpiDay.m

%global variables
V=Virus;
V.Ic=V.Reported_inf_rate/V.NcontactsPerReported_inf_rate;
P=Person;  %initial type Person in Population

InitialContagious=20;
nCommunity=2000;

N_Days=360+V.t_T;               %number of days in the epidemic
% An EpiDay records the state of the epidemic for each day
E_Days(N_Days)=EpiDay;          %initial array to type EpiDay

%initial the model
%initial model utilized one average person to build population. This could
%be changed by running the model with percentages of person types and
%agreggating the results
AveContactsPerDay=P.social;  
%initial the population
E_Days(1).NewContagious=0;
E_Days(1).TContagious=InitialContagious;
%Set up the initial exposure window
for i=1:V.t_E
E_Days(i).CurrentContagious=InitialContagious;
E_Days(i).TContagious=InitialContagious;
E_Days(i).Vulnerable=nCommunity-InitialContagious;
E_Days(i+V.t_Sym).TSick=E_Days(1).CurrentContagious*(1-V.V_A);
end   
%initial number Vulnerable
for i=V.t_E:V.t_T
    E_Days(i).Vulnerable=nCommunity-InitialContagious;
end
%compute changes for each day
for i=V.t_E:N_Days %start exposure days after model begin

    %Set NewContagious - need to look back V.t_E days
    Exposure=AveContactsPerDay*V.t_T*V.Ic; %units 
    index=i-V.t_E+1; %Matlab doesn't support 0 index
    vulnerable=E_Days(index).Vulnerable;  %grab V.t_E days back
    newC=Exposure*vulnerable*E_Days(index).CurrentContagious/nCommunity;  
    
    %update vulnerable
    vulnerable=E_Days(i-1).Vulnerable; %grab previous day
    E_Days(i).Vulnerable=vulnerable-newC; 
    if (E_Days(i).Vulnerable<1) E_Days(i).Vulnerable=0; end %can't go below 0
    
    %update contagious variables
    E_Days(i).TContagious=newC+E_Days(i-1).TContagious;
    if ( E_Days(i).TContagious>nCommunity)
        %can't exceed the total population
        difference=E_Days(i).TContagious-nCommunity; %correct new contagious
        newC=newC-difference;
        E_Days(i).TContagious=nCommunity; %correct total contagious
    end
    %update Current Contagious
    E_Days(i).NewContagious=newC;
    CurrentContagious=E_Days(i-1).CurrentContagious+newC;
    %Subtract those no longer contagious looking back
    if (i-V.t_T>0)
        CurrentContagious=CurrentContagious-E_Days(i-V.t_T).NewContagious;
    end
    if (CurrentContagious>nCommunity) %correct if larger than population
        CurrentContagious=nCommunity; 
    end
    if (CurrentContagious>0) 
        E_Days(i).CurrentContagious=CurrentContagious;
    else 
        E_Days(i).CurrentContagious=0;
    end %if
     
    %Set remaining changes
    %sick
    newsick=newC*(1-V.V_A);
    index=i+V.t_E+V.t_Sym; %Exposed time plus time to symptoms
    E_Days(index).NewSick=newsick;
    E_Days(index).CurrentSick=newsick+E_Days(index-1).CurrentSick;
    if (i>V.t_D) %if past sick duration then subtract
         E_Days(index).CurrentSick=E_Days(index).CurrentSick-E_Days(index-V.t_D).NewSick;
    end
    if (E_Days(index).CurrentSick>nCommunity)
        E_Days(index).CurrentSick=nCommunity;
    else if (E_Days(index).CurrentSick<0)
       E_Days(index).CurrentSick=0;
        end
    end
    E_Days(index).TSick=newsick+E_Days(index-1).TSick;
    if (E_Days(index).TSick>nCommunity) 
        E_Days(index).TSick=nCommunity; 
    end
    index=i+V.t_T; %can compute dead, recovered V.t_T days ahead
    E_Days(index).NewDead=newsick * V.V_D;
    E_Days(index).TDead=E_Days(index-1).TDead+E_Days(index).NewDead;
    E_Days(index).NewRecovered=newsick*(1-V.V_D);
    E_Days(index).TRecovered= E_Days(index-1).TRecovered+E_Days(index).NewRecovered; 
end %for

N_Days=360; %number of days to plot
c=1:N_Days;

hold off
for i=1:N_Days
c(i)=E_Days(i).TDead;
end
plot(c);
hold on
for i=1:N_Days
c(i)=E_Days(i).CurrentContagious;
end
plot(c)
for i=1:N_Days
c(i)=E_Days(i).CurrentSick;
end
plot(c);
legend("Total Dead","CurrentCintagious","Current Sick" );



