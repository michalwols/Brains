brain = importdata('nmri_brain.mat');

figure(1);
imagesc(brain);

figure(2);
hist( brain( brain > 10 ) );

[ clustered, means ] = K_means( brain, 4, [0, 15, 70, 105] );
