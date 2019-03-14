library(ggplot2)
library(gridExtra)

RW7LC3_1D_no_bobbin_simulation_raw_data <- read_excel("C:/Users/502740/Documents/R/win-library/Bode/RW7LC3 1D no bobbin simulation raw data.xlsx")

Thinarm_Sim=subset(RW7LC3_1D_no_bobbin_simulation_raw_data,DESIGN=='RW71D no Bobbin, Version 1 (Thin Arm)')
H1_Sim=subset(Thinarm_Sim, HEAD=='H1')
H0_Sim=subset(Thinarm_Sim, HEAD=='H0')

H0_Sim$VCMGAIN=H0_Sim$VCMGAIN+25 ## VCMGAIN offset by + 25
H1_Sim$VCMGAIN=H1_Sim$VCMGAIN+25 ## VCMGAIN offset by + 25

p282_bode_gain_phase_RL36_BobbinRemoval <- read_csv("C:/Users/502740/Documents/R/win-library/Bode/p282_bode_gain_phase_RL36_BobbinRemoval.csv")


H1_actual=subset(p282_bode_gain_phase_RL36_BobbinRemoval, HD_PHYS_PSN==1)
H0_actual=subset(p282_bode_gain_phase_RL36_BobbinRemoval, HD_PHYS_PSN==0)

H1_actual_PZT=subset(H1_actual, OCCURRENCE==9)
H0_actual_PZT=subset(H0_actual, OCCURRENCE==9)

H1_actual_PZT$PEAK_FREQUENCY=H1_actual_PZT$PEAK_FREQUENCY/1000
H0_actual_PZT$PEAK_FREQUENCY=H0_actual_PZT$PEAK_FREQUENCY/1000

c=ggplot(H1_Sim,aes(FREQUENCY,PZTGAIN))+geom_line(color='indianred')+lims(x=c(0,35),y=c(-40,40))+labs(title="PZT Simulation Hd1",y="Gain(dB)",x="Frequency(kHz)")
d=ggplot(H0_Sim,aes(FREQUENCY,PZTGAIN))+geom_line(color='darkblue')+lims(x=c(0,35),y=c(-40,40))+labs(title="PZT Simulation Hd0",y="Gain(dB)",x="Frequency(kHz)")
#grid.arrange(a,b)

c1=ggplot(H1_actual_PZT,aes(PEAK_FREQUENCY,GAIN))+geom_point(color='indianred',alpha=0.1)+lims(x=c(0,35),y=c(-40,40))+labs(title="PZT Actual Hd1",y="Gain(dB)",x="Frequency(kHz)")
d1=ggplot(H0_actual_PZT,aes(PEAK_FREQUENCY,GAIN))+geom_point(color='darkblue',alpha=0.1)+lims(x=c(0,35),y=c(-40,40))+labs(title="PZT Actual Hd0",y="Gain(dB)",x="Frequency(kHz)")

grid.arrange(c,d,c1,d1)


