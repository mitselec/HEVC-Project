%----------------------------------------------%
%--- First Stage of Inverse & Forward DCT   ---%
%----             In HEVC                  ----%
%----     Dimopoulos Dimitrios 2015        ----%
%----------------------------------------------%


%% Matrix Calculation
%------ Matrix Parts Declaration ------%
% Declaring the basic rows used to create
% the DCT matrices

d1 = [64,64,64,64];
d2 = [89,75,50,18];
d3 = [83,36,-36,-83];
d4 = [75,-18,-89,-50];
d5 = [64,-64,-64,64];
d6 = [50,-89,18,75];
d7 = [36,-83,83,-36];
d8 = [18,-50,75,-89];

d9 = [90,87,80,70,57,43,25,9];
d10 = [87,57,9,-43,-80,-90,-70,-25];
d11 = [80,9,-70,-87,-25,57,90,43];
d12 = [70,-43,-87,9,90,25,-80,-57];
d13 = [57,-80,-25,90,-9,-87,43,70];
d14 = [43,-90,57,25,-87,70,9,-80];
d15 = [25,-70,90,-80,43,9,-57,87];
d16 = [9,-25,43,-57,70,-80,87,-90];

d17 = [90,90,88,85,82,78,73,67,61,54,46,38,31,22,13,4];
d18 = [90,82,67,46,22,-4,-31,-54,-73,-85,-90,-88,-78,-61,-38,-13];
d19 = [88,67,31,-13,-54,-82,-90,-78,-46,-4,38,73,90,85,61,22];
d20 = [85,46,-13,-67,-90,-73,-22,38,82,88,54,-4,-61,-90,-78,-31];
d21 = [82,22,-54,-90,-61,13,78,85,31,-46,-90,-67,4,73,88,38];
d22 = [78,-4,-82,-73,13,85,67,-22,-88,-61,31,90,54,-38,-90,-46];
d23 = [73,-31,-90,-22,78,67,-38,-90,-13,82,61,-46,-88,-4,85,54];
d24 = [67,-54,-78,38,85,-22,-90,4,90,13,-88,-31,82,46,-73,-61];
d25 = [61,-73,-46,82,31,-88,-13,90,-4,-90,22,85,-38,-78,54,67];
d26 = [54,-85,-4,88,-46,-61,82,13,-90,38,67,-78,-22,90,-31,-73];
d27 = [46,-90,38,54,-90,31,61,-88,22,67,-85,13,73,-82,4,78];
d28 = [38,-88,73,-4,-67,90,-46,-31,85,-78,13,61,-90,54,22,-82];
d29 = [31,-78,90,-61,4,54,-88,82,-38,-22,73,-90,67,-13,-46,85];
d30 = [22,-61,85,-90,73,-38,-4,46,-78,90,-82,54,-13,-31,67,-88];
d31 = [13,-38,61,-78,88,-90,85,-73,54,-31,4,22,-46,67,-82,90];
d32 = [4,13,22,-31,38,-46,54,-61,67,-73,78,-82,85,-88,90,-90];


%--------- Matrix Declaration ---------%

% 4x4 DCT matrix 
DCT4 = [d1;d3;d5;d7];

% 8x8 DCT matrix
DCT8 = [d1,d1;d2,-wrev(d2);d3,wrev(d3);d4,-wrev(d4);d5,d5;d6,-wrev(d6);...
        d7,wrev(d7);d8,-wrev(d8)];

% 16x16 DCT matrix
DCT16 = [DCT8(1,:),DCT8(1,:);d9,-wrev(d9);DCT8(2,:),wrev(DCT8(2,:));  ...
         d10,-wrev(d10);DCT8(3,:),wrev(DCT8(3,:));d11,-wrev(d11);     ...
         DCT8(4,:),DCT8(4,:);d12,-wrev(d12);DCT8(5,:),wrev(DCT8(5,:));...
         d13,-wrev(d13);DCT8(6,:),wrev(DCT8(6,:));d14,-wrev(d14);     ...
         DCT8(7,:),DCT8(7,:);d15,-wrev(d15);DCT8(8,:),wrev(DCT8(8,:));...
         d16,-wrev(d16)];
     
% 32x32 DCT matrix
DCT32 = [DCT16(1,:),wrev(DCT16(1,:));d17,-wrev(d17); ...
         DCT16(2,:),wrev(DCT16(2,:));d18,-wrev(d18); ...
         DCT16(3,:),wrev(DCT16(3,:));d19,-wrev(d19); ...
         DCT16(4,:),wrev(DCT16(4,:));d20,-wrev(d20); ...
         DCT16(5,:),wrev(DCT16(5,:));d21,-wrev(d21); ...
         DCT16(6,:),wrev(DCT16(6,:));d22,-wrev(d22); ...
         DCT16(7,:),wrev(DCT16(7,:));d23,-wrev(d23); ...
         DCT16(8,:),wrev(DCT16(8,:));d24,-wrev(d24); ...
         DCT16(9,:),wrev(DCT16(9,:));d25,-wrev(d25); ...
         DCT16(10,:),wrev(DCT16(10,:));d26,-wrev(d26); ...
         DCT16(11,:),wrev(DCT16(11,:));d27,-wrev(d27); ...
         DCT16(12,:),wrev(DCT16(12,:));d28,-wrev(d28); ...
         DCT16(13,:),wrev(DCT16(13,:));d29,-wrev(d29); ...
         DCT16(14,:),wrev(DCT16(14,:));d30,-wrev(d30); ...
         DCT16(15,:),wrev(DCT16(15,:));d31,-wrev(d31); ...
         DCT16(16,:),wrev(DCT16(16,:));d32,-wrev(d32)];



%% Scaling Factors Calculation

%Bit Depth B
B = 8;
%Matrix Size
M4 = 4;
M8 = 8;
M16 = 16;
M32 = 32;
%Inverse Stage Scaling
SIT = 2^7;
%Forward Stage Scaling
ST4 = 2^-(B+log2(M4)-9);
ST8 = 2^-(B+log2(M8)-9);
ST16 = 2^-(B+log2(M16)-9);
ST32 = 2^-(B+log2(M32)-9);

%% Input Declaration
%--------- Input  Declaration ---------%
%random input
% 4 point input
in4 = randi(256,4);
% 8 point input
in8 = randi(256,8);
% 16 point input 
in16 = randi(256,16);
% 32 point input
in32 = randi(256,32);


%% DCT Output

%--------------- OUTPUT ---------------%

%---------------- 4 X 4 ---------------%
%Inverse Transform -- Multiplication of the 
%Transpose DCT Matrix with our input + scaling 
inv4 = (transpose(DCT4)* in4)/ SIT;

%Forward Transform -- Multiplication of the 
%DCT Matrix with our input + scaling
fwd4 = (DCT4 * in4)* ST4;

%---------------- 8 X 8 ---------------%
%Inverse Transform -- Multiplication of the 
%Transpose DCT Matrix with our input + scaling 
inv8 = (transpose(DCT8)* in8) / SIT;

%Forward Transform -- Multiplication of the 
%DCT Matrix with our input + scaling
fwd8 = (DCT8 * in8) * ST8;

%--------------- 16 X 16 --------------%
%Inverse Transform -- Multiplication of the 
%Transpose DCT Matrix with our input + scaling 
inv16 = (transpose(DCT16)* in16) / SIT;

%Forward Transform -- Multiplication of the 
%DCT Matrix with our input + scaling
fwd16 = (DCT16 * in16) * ST16;

%--------------- 32 X 32 --------------%
%Inverse Transform -- Multiplication of the 
%Transpose DCT Matrix with our input + scaling 
inv32 = (transpose(DCT32)* in32) / SIT;

%Forward Transform -- Multiplication of the 
%DCT Matrix with our input + scaling
fwd32 = (DCT32 * in32) * ST32;


