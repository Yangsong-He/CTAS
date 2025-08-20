figure,
errorbar(grid_noiselevel,mean(AUC_noise,2),std(AUC_noise,0,2),'o-.','color',[0.5 0.5 0.5],'LineWidth',1,'MarkerSize',12,'MarkerFaceColor',[0 0.8 0]);title('AUC for network inference','FontWeight', 'bold'); axis([-1 21 0 1]); 
set(gca,'FontSize',15)
xlabel('Noise level (%)','FontSize',20);
figure,
errorbar(grid_noiselevel,mean(Accuracy_noise,2),std(Accuracy_noise,0,2),'o-.','color',[0.5 0.5 0.5],'LineWidth',1,'MarkerSize',12,'MarkerFaceColor',[0 0.8 0]); title('Accuracy for network inference','FontWeight', 'bold'); axis([-1 21 0 1]);
set(gca,'FontSize',15)
xlabel('Noise level (%)','FontSize',20);
figure,
errorbar(grid_noiselevel,mean(PPV_noise,2),std(PPV_noise,0,2),'o-.','color',[0.5 0.5 0.5],'LineWidth',1,'MarkerSize',12,'MarkerFaceColor',[0 0.8 0]); title('PPV for network inference','FontWeight', 'bold'); axis([-1 21 0 1]);
set(gca,'FontSize',15)
xlabel('Noise level (%)','FontSize',20);
figure,
errorbar(grid_noiselevel,mean(MCC_noise,2),std(MCC_noise,0,2),'o-.','color',[0.5 0.5 0.5],'LineWidth',1,'MarkerSize',12,'MarkerFaceColor',[0 0.8 0]); title('MCC for network inference','FontWeight', 'bold'); axis([-1 21 0 1]); % axis([-1 31  0 max(mean(MCC_noise,2)+std(MCC_noise,0,2))])
set(gca,'FontSize',15)
xlabel('Noise level (%)','FontSize',20);
figure,
errorbar(grid_noiselevel,mean(S_distance,2),std(S_distance,0,2),'o-.','color',[0.5 0.5 0.5],'LineWidth',1,'MarkerSize',12,'MarkerFaceColor',[0 0 1]);title('RMSE for progression inference','FontWeight', 'bold'); axis([-1 21 0 0.5]); % axis([-1 31  0 max(mean(S_distance,2)+std(S_distance,0,2))])
set(gca,'FontSize',15)
xlabel('Noise level (%)','FontSize',20);
figure,
errorbar(grid_noiselevel,mean(coeff_Spearman,2),std(coeff_Spearman,0,2),'o-.','color',[0.5 0.5 0.5],'LineWidth',1,'MarkerSize',12,'MarkerFaceColor',[0 0 1]);title('Spearman correlation for progression inference','FontWeight', 'bold'); axis([-1 21 0 1]); % axis([-1 31  0 max(mean(S_distance,2)+std(S_distance,0,2))])
set(gca,'FontSize',15)
xlabel('Noise level (%)','FontSize',20);