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


void compare_difference(){

//=======================rootlogon.C=========================

TStyle *myStyle  = new TStyle("MyStyle","My Root Styles");

// from ROOT plain style
myStyle->SetCanvasBorderMode(0);
myStyle->SetPadBorderMode(0);
myStyle->SetPadColor(0);
myStyle->SetCanvasColor(0);
myStyle->SetTitleColor(1);
myStyle->SetStatColor(0);

myStyle->SetLabelSize(0.025,"xyz"); // size of axis values
myStyle->SetLabelOffset(0.01);
// default canvas positioning
myStyle->SetCanvasDefX(900);
myStyle->SetCanvasDefY(20);
myStyle->SetCanvasDefH(550);
myStyle->SetCanvasDefW(540);

myStyle->SetTitleYOffset(1.3);
myStyle->SetTitleXOffset(1.3);

myStyle->SetPadBottomMargin(0.15);
myStyle->SetPadTopMargin(0.15);
myStyle->SetPadLeftMargin(0.15);
myStyle->SetPadRightMargin(0.15);
myStyle->SetPadTickX(1);
myStyle->SetPadTickY(1);
myStyle->SetFrameBorderMode(0);

// Din letter
myStyle->SetPaperSize(21, 28);
myStyle->SetOptStat(111111);// Show overflow and underflow as well
myStyle->SetOptFit(1011);
myStyle->SetPalette(1);

// apply the new style
gROOT->SetStyle("MyStyle"); //uncomment to set this style
gROOT->ForceStyle(); // use this style, not the one saved in root files

//==========================rootlogon end======================

TCanvas *c = new TCanvas("c","LCT efficiency", 1200, 1200);

Double_t hv[] = {3300,3400,3450,3500,3550,3600,3602,3650,3700,3800}; // Enter the values by hand
Double_t lct_bh[] = {0.08092665697,0.6258749042,0.891469406,0.9720276246,0.9854820265,0.9891063745,0.9893270307,0.9906881785,0.990769537,0.9920099564}; // Enter the values by hand
Double_t lct_jake[] = {0.080866473,0.626092878,0.891563338,0.972086092,0.985453219,0.989292817,0.989440319,0.990660298,0.990715132,0.992023745}; //Enter the values by hand

for (int i=0; i<11; i++) lct_jake[i]-=lct_bh[i];

TGraph *g1 = new TGraph(sizeof(hv)/sizeof(Double_t),hv,lct_jake);
//TGraph *g2 = new TGraph(sizeof(hv)/sizeof(Double_t),hv,lct_bh);
TMultiGraph *mg = new TMultiGraph();
//TLegend *leg = new TLegend(0.66,0.21,0.81,0.36);

mg->Add(g1,"pL");
//mg->Add(g2,"p");

//leg->AddEntry(g1,"LCT efficiency (Bhargav)");
//leg->AddEntry(g2,"LCT efficiency (Jake)");

mg->Draw("ap");
//leg->Draw("same");

g1->SetTitle("LCT Efficiency difference vs HV");
g1->SetMarkerStyle(13);
g1->SetMarkerSize(2);
g1->SetMarkerColor(kBlue); 

//g2->SetMarkerStyle(13);
//g2->SetMarkerSize(2);
//g2->SetMarkerColor(kOrange+7);

mg->GetYaxis()->SetTitle("Difference");
mg->GetXaxis()->SetLimits(3200, 3900);
//mg->SetMinimum(0);
//mg->SetMaximum(1);
mg->GetXaxis()->SetTitleSize(0.025);
mg->GetYaxis()->SetTitleSize(0.025);
mg->GetXaxis()->SetTitle("Voltage [V]");
c->SaveAs("comparedifferencePlots_new.png");
}
