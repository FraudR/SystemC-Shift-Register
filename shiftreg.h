#include "dff/dff.h"

SC_MODULE(shiftreg) {
	//port declaration
	sc_in<bool> din;
	sc_in<bool> clr;
	sc_in<bool> clk;
	
	sc_out<bool> QA;
	sc_out<bool> QB;
	sc_out<bool> QC;
	sc_out<bool> QD;
	
	dff ffa{"flipflop_a"};
	dff ffb{"flipflop_b"};
	dff ffc{"flipflop_c"};
	dff ffd{"flipflop_d"};
	
	// function declaration/implementation
	void shiftreg_function();
	
	//constructor
	SC_CTOR(shiftreg){
		ffa.din(din);
		ffa.clk(clk);
		ffa.clr(clr);
		ffa.dout(QA);
		
		ffb.din(ffa.dout);
		ffb.clk(clk);
		ffb.clr(clr);
		ffb.dout(QB);
		
		ffc.din(ffb.dout);
		ffc.clk(clk);
		ffc.clr(clr);
		ffc.dout(QC);
		
		ffd.din(ffc.dout);
		ffd.clk(clk);
		ffd.clr(clr);
		ffd.dout(QD);		
		//SC_METHOD(shiftreg_function);
		sensitive << clk.pos();
	}


		

};
