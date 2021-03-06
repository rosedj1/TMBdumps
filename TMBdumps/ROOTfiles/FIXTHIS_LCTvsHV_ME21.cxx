#include <iostream>
#include <fstream>
#include <sstream>
#include <vector>
#include <algorithm>
#include "TSystem.h"
#include "TObject.h"
#include "TFile.h"
#include "TROOT.h"
#include "TAttMarker.h"
#include "TAttAxis.h"
#include "TAttLine.h"
#include "TAxis.h"
#include "TMultiGraph.h"
#include "TGraph.h"
#include "TCanvas.h"
#include "TLegend.h"
#include "TStyle.h"
#include "TH1.h"
#include "TPad.h"
#include "TStyle.h"
#include "TH1F.h"
#include "TColor.h"
#include "TLatex.h"
#include "TFrame.h"
#include "TFile.h"
#include "TF1.h"
#include "TColor.h"
#include "TString.h"
#include "TGraphErrors.h"
#include "TPad.h"
#include "TLine.h"
//#include "TVirtualPad.h"
//#include "tdrstyle.C"

void LCTvsHV_ME11(){

TCanvas* c1 = new TCanvas("c1","LCT efficiency of ME2/1 ", 2000, 2000);
c1->SetFillColor(kGray);
c1->SetGrid();

int xmin = 2550, xmax = 3050; 
Float_t ymin = 0.25, ymax = 1, HV0 = 2869.1667;

TH1F* hr = c1->DrawFrame(xmin,ymin,xmax,ymax,"Average LCT Efficiency of ME1/1, srcOFF");
hr->SetXTitle("HV [V]");
hr->SetYTitle("Avg LCT Efficiency");
//gPad->GetTickx();
//hr->GetXaxis()->SetLabelOffset(0.01);
//hr->GetYaxis()->SetTitleOffset(1.2);
c1->GetFrame()->SetFillColor(kWhite);
c1->GetFrame()->SetBorderSize(8);

TGraphErrors* g1 = new TGraphErrors("./ME11_srcOFF_T40.txt","%lg %lg %lg");
//TGraphErrors* g2 = new TGraphErrors("./eqME11_srcOFF_T40_refME21.txt","%lg %lg %lg");
//TGraphErrors* g3 = new TGraphErrors("./eqME11_srcOFF_T40_refME21.txt","%lg %lg %lg");

//ifstream 
g1->SetMarkerColor(kOrange+7);
g1->SetMarkerStyle(21);
g1->SetLineColor(kOrange+2);
g1->Draw("LP");

//g2->SetMarkerColor(kRed);
//g2->SetMarkerStyle(20);
//g2->SetLineColor(kRed);
//g2->Draw("LP");

//g3->SetMarkerColor(kGreen+2);
//g3->SetMarkerStyle(22);
//g3->SetLineColor(kGreen+2);
//g3->Draw("LP");

// Draw a line to indicate HV0
TLine* line = new TLine();
line->SetLineStyle(4);
line->DrawLine(HV0,ymin,HV0,ymax);

//(x1, y1, x2, y2)
TLegend *leg = new TLegend(0.62,0.7,0.89,0.8);
//leg->AddEntry(g1,"same HV on each layer","lep");
//leg->AddEntry(g2,"equalized gain, diff. HV for each layer","lep");
//leg->AddEntry(g3,"equalized gain, diff. HV for each layer (dual readout)","lep");
//leg->AddEntry(line,"average HV0 = 2869.2 V ","l");
leg->AddEntry(line,"Equalized gas gain for each layer","l");
leg->AddEntry(line,"(average HV0 = 2869.2 V)","");
leg->Draw("same");

//c1->BuildLegend();

//c1->SaveAs("EFFPLAT_ME21_srcOFF_compare.pdf");
}

#ifndef __CINT__
int main()
{
	//setTDRStyle();
	LCTvsHV_ME11();
	return 0;
}
#endif

//=======================rootlogon.C=========================

//TStyle *myStyle  = new TStyle("MyStyle","My Root Styles");

// from ROOT plain style
//myStyle->SetCanvasBorderMode(0);
//myStyle->SetPadBorderMode(0);
//myStyle->SetPadColor(0);
//myStyle->SetCanvasColor(0);
//myStyle->SetTitleColor(1);
//myStyle->SetStatColor(0);

//myStyle->SetLabelSize(0.025,"xyz"); // size of axis values
//myStyle->SetLabelOffset(0.01);
// default canvas positioning
//myStyle->SetCanvasDefX(900);
//myStyle->SetCanvasDefY(20);
//myStyle->SetCanvasDefH(550);
//myStyle->SetCanvasDefW(540);

//myStyle->SetTitleYOffset(1.3);
//myStyle->SetTitleXOffset(1.3);

//myStyle->SetPadBottomMargin(0.15);
//myStyle->SetPadTopMargin(0.15);
//myStyle->SetPadLeftMargin(0.15);
//myStyle->SetPadRightMargin(0.15);
//myStyle->SetPadTickX(1);
//myStyle->SetPadTickY(1);
//myStyle->SetFrameBorderMode(0);

// Din letter
//myStyle->SetPaperSize(21, 28);
//myStyle->SetOptStat(111111);// Show overflow and underflow as well
//myStyle->SetOptFit(1011);
//myStyle->SetPalette(1);

// apply the new style
//gROOT->SetStyle("MyStyle"); //uncomment to set this style
//gROOT->ForceStyle(); // use this style, not the one saved in root files

//==========================rootlogon end======================
// DrawFrame(xmin, ymin, xmax, ymax, title = " ")
//TH1F* hr = c1->DrawFrame(2000,0,4000,1,"EFF PLATEAU: Average LCT Efficiency of ME1/1, srcOFF");
//Double_t hv[] = {3300,3350,3400,3450,3500,3550,3600,3602,3650,3700,3800}; // Enter the values by hand
//Double_t lct_bh[] = {0.08092665697,0.2692073986,0.6258749042,0.891469406,0.9720276246,0.9854820265,0.9891063745,0.9893270307,0.9906881785,0.990769537,0.9920099564}; // Enter the values by hand
//Double_t lct_jake[] = {0.080866473,0.291661788,0.626092878,0.891563338,0.972086092,0.985453219,0.989292817,0.989440319,0.990660298,0.990715132,0.992023745}; //Enter the values by hand

//TGraph *g1 = new TGraph(sizeof(hv)/sizeof(Double_t),hv,lct_jake);
//TGraph *g2 = new TGraph(sizeof(hv)/sizeof(Double_t),hv,lct_bh);
//TMultiGraph *mg = new TMultiGraph();

//g1->SetTitle("Average LCT Efficiency vs. HV");
//g1->SetMarkerStyle(13);
//g1->SetMarkerSize(2);
//g1->SetMarkerColor(kBlue); 

//g2->SetMarkerStyle(13);
//g2->SetMarkerSize(2);
//g2->SetMarkerColor(kOrange+7);

//mg->GetYaxis()->SetTitle("Efficiency");
//mg->GetXaxis()->SetTitle("Voltage [V]");
//mg->GetXaxis()->SetLimits(2700, 3020);
//mg->SetMinimum(0.975);
//mg->SetMaximum(1);
//mg->GetXaxis()->SetTitleSize(0.025);
//mg->GetYaxis()->SetTitleSize(0.025);

//mg->Add(g1,"p");
//mg->Add(g2,"p");
//
//mg->Draw("AELP");
