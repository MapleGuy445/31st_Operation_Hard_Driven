// ============================================================
//  TURRET ROTATION CONTROL PANEL
// ============================================================
#define IDC_TRC_SLIDER   110
#define IDC_TRC_ZSLIDER  113
#define IDC_TRC_CLOSE    112

#define TRC_X  0.17
#define TRC_Y  0.08
#define TRC_W  0.66
#define TRC_H  0.84

// Band heights
#define TRC_TITLE_H    0.078
#define TRC_SUB_H      0.054
#define TRC_DIVIDER_H  0.003
#define TRC_LABEL_H    0.048
#define TRC_SLIDER_H   0.096
#define TRC_ROW_H      0.045
#define TRC_ROW_GAP    0.006
#define TRC_STATUS_H   0.048
#define TRC_FOOTER_H   0.045
#define TRC_BTN_H      0.087
#define TRC_BTN_W      0.291
#define TRC_MARGIN     0.018

// Top-down Y positions
#define TRC_TITLE_Y    TRC_Y
#define TRC_SUB_Y      TRC_TITLE_Y + TRC_TITLE_H
#define TRC_DIV1_Y     TRC_SUB_Y + TRC_SUB_H
#define TRC_LABEL_Y    TRC_DIV1_Y + TRC_DIVIDER_H + 0.009
#define TRC_SLIDER_Y   TRC_LABEL_Y + TRC_LABEL_H + 0.006
#define TRC_LABEL2_Y   TRC_SLIDER_Y + TRC_SLIDER_H + 0.006
#define TRC_SLIDER2_Y  TRC_LABEL2_Y + TRC_LABEL_H + 0.006
#define TRC_ROWS_Y     TRC_SLIDER2_Y + TRC_SLIDER_H + 0.012
#define TRC_ROW2_Y     TRC_ROWS_Y + TRC_ROW_H + TRC_ROW_GAP
#define TRC_ROW3_Y     TRC_ROW2_Y + TRC_ROW_H + TRC_ROW_GAP
#define TRC_ROW4_Y     TRC_ROW3_Y + TRC_ROW_H + TRC_ROW_GAP
#define TRC_ROW5_Y     TRC_ROW4_Y + TRC_ROW_H + TRC_ROW_GAP

// Bottom-up Y positions
#define TRC_FOOTER_Y   TRC_Y + TRC_H - TRC_FOOTER_H
#define TRC_STATUS_Y   TRC_FOOTER_Y - TRC_STATUS_H
#define TRC_DIV2_Y     TRC_STATUS_Y - TRC_DIVIDER_H
#define TRC_BTN_Y      TRC_DIV2_Y - TRC_BTN_H - 0.009

// Button X
#define TRC_BTN_L_X    TRC_X + TRC_MARGIN
#define TRC_BTN_R_X    TRC_X + TRC_W - TRC_MARGIN - TRC_BTN_W

class TurretRotationControl {
    idd = 9003;
    movingEnable = false;
    enableSimulation = false;
    onLoad   = "(_this select 0) call MY_fnc_turretPanelLoad";
    onUnload = "[(_this select 0), (_this select 1)] call MY_fnc_turretPanelClose";

    class ControlsBackground {

        class Background : RscText {
            idc = -1;
            x = TRC_X;  y = TRC_Y;
            w = TRC_W;  h = TRC_H;
            colorBackground[] = {0.03, 0.04, 0.05, 0.97};
        };

        class TitleBar : RscText {
            idc = -1;
            text = "TURRET ROTATION CONTROL PANEL";
            x = TRC_X;  y = TRC_TITLE_Y;
            w = TRC_W;  h = TRC_TITLE_H;
            colorBackground[] = {0.40, 0.05, 0.05, 1.0};
            colorText[]       = {1, 1, 1, 1};
            sizeEx            = 0.042;
        };

        class SubLabel : RscText {
            // Text is set dynamically from SQF based on current panel state
            text = "ESTABLISHING CONNECTION...";
            idc = 9010;
            x = TRC_X;  y = TRC_SUB_Y;
            w = TRC_W;  h = TRC_SUB_H;
            colorBackground[] = {0.04, 0.10, 0.18, 0.97};
            colorText[]       = {0.30, 0.65, 1.00, 1};
            sizeEx            = 0.033;
        };

        class Divider1 : RscLine {
            idc = -1;
            x = TRC_X;  y = TRC_DIV1_Y;
            w = TRC_W;  h = TRC_DIVIDER_H;
            colorBackground[] = {0.80, 0.20, 0.20, 0.8};
        };

        class InputLabel : RscText {
            idc = -1;
            text = "TURRET ROTATION ANGLE:";
            x = TRC_X + TRC_MARGIN;  y = TRC_LABEL_Y;
            w = TRC_W - TRC_MARGIN*2;  h = TRC_LABEL_H;
            colorBackground[] = {0, 0, 0, 0};
            colorText[]       = {0.90, 0.80, 0.70, 1};
            sizeEx            = 0.033;
        };

		class InputLabel2 : RscText {
			idc = -1;
			text = "TURRET Z-AXIS ROTATION:";
			x = TRC_X + TRC_MARGIN;  y = TRC_LABEL2_Y;
			w = TRC_W - TRC_MARGIN*2;  h = TRC_LABEL_H;
			colorBackground[] = {0, 0, 0, 0};
			colorText[]       = {0.90, 0.80, 0.70, 1};
			sizeEx            = 0.033;
		};

        class Divider2 : RscLine {
            idc = -1;
            x = TRC_X;  y = TRC_DIV2_Y;
            w = TRC_W;  h = TRC_DIVIDER_H;
            colorBackground[] = {0.80, 0.20, 0.20, 0.8};
        };

        class StatusBar : RscText {
            idc = -1;
            text = "DRAG THE BAR TO ROTATE THE TURRET";
            x = TRC_X;  y = TRC_STATUS_Y;
            w = TRC_W;  h = TRC_STATUS_H;
            colorBackground[] = {0.04, 0.07, 0.12, 0.97};
            colorText[]       = {0.65, 0.55, 0.45, 1};
            sizeEx            = 0.025;
        };

        class Footer : RscText {
            idc = -1;
            text = "WARNING: ROTATION CHANGES ARE APPLIED IMMEDIATELY.";
            x = TRC_X;  y = TRC_FOOTER_Y;
            w = TRC_W;  h = TRC_FOOTER_H;
            colorBackground[] = {0.09, 0.03, 0.03, 0.97};
            colorText[]       = {0.85, 0.38, 0.32, 1};
            sizeEx            = 0.022;
        };
    };

    class Controls {

        class RotationSlider : RscXSliderH {
            idc  = IDC_TRC_SLIDER;
            x = TRC_X + TRC_MARGIN;  y = TRC_SLIDER_Y + 0.02;
            w = TRC_W - TRC_MARGIN*2 - 0.09;  h = TRC_SLIDER_H - 0.04;
            colorBackground[] = {0.04, 0.06, 0.10, 1.0};
            color[]           = {1.00, 0.30, 0.30, 1};
            sliderRange[]     = {0, 1};
            sliderSpeed       = 0.01;
            sliderPosition    = 0;
            onSliderPosChanged = "[(_this select 0), (_this select 1)] call MY_fnc_turretSliderChanged;";
			onMouseButtonDown  = "call MY_fnc_turretSliderDragStart;";
    		onMouseButtonUp    = "call MY_fnc_turretSliderDragEnd;";
        };

        class ValueReadout : RscText {
            idc  = 9013;
            text = "0.000";
            x = TRC_X + TRC_W - TRC_MARGIN - 0.08;  y = TRC_SLIDER_Y + 0.02;
            w = 0.08;  h = TRC_SLIDER_H - 0.04;
            colorBackground[] = {0.04, 0.06, 0.10, 1.0};
            colorText[]       = {1.00, 0.30, 0.30, 1};
            sizeEx            = 0.033;
        };

		class ZRotationSlider : RscXSliderH {
			idc  = IDC_TRC_ZSLIDER;
			x = TRC_X + TRC_MARGIN;  y = TRC_SLIDER2_Y + 0.02;
			w = TRC_W - TRC_MARGIN*2 - 0.09;  h = TRC_SLIDER_H - 0.04;
			colorBackground[] = {0.04, 0.06, 0.10, 1.0};
			color[]           = {0.30, 0.70, 1.00, 1};
			sliderRange[]     = {0, 1};
			sliderSpeed       = 0.01;
			sliderPosition    = 0;
			onSliderPosChanged = "[(_this select 0), (_this select 1)] call MY_fnc_turretZSliderChanged;";
			onMouseButtonDown  = "call MY_fnc_turretZSliderDragStart;";
			onMouseButtonUp    = "call MY_fnc_turretZSliderDragEnd;";
		};

		class ZValueReadout : RscText {
			idc  = 9014;
			text = "0.000";
			x = TRC_X + TRC_W - TRC_MARGIN - 0.08;  y = TRC_SLIDER2_Y + 0.02;
			w = 0.08;  h = TRC_SLIDER_H - 0.04;
			colorBackground[] = {0.04, 0.06, 0.10, 1.0};
			colorText[]       = {0.30, 0.70, 1.00, 1};
			sizeEx            = 0.033;
		};

        // Status readout rows
        class Row1 : RscText {
            idc = -1;
            text = "SYSTEM: TURRET LINK ACTIVE";
            x = TRC_X + TRC_MARGIN;  y = TRC_ROWS_Y;
            w = TRC_W - TRC_MARGIN*2;  h = TRC_ROW_H;
            colorBackground[] = {0.04, 0.06, 0.10, 0.8};
            colorText[]       = {0.30, 0.70, 1.00, 0.9};
            sizeEx            = 0.025;
        };

        class Row2 : RscText {
            idc = 9011;
            text = "TARGET TURRET: READING...";
            x = TRC_X + TRC_MARGIN;  y = TRC_ROW2_Y;
            w = TRC_W - TRC_MARGIN*2;  h = TRC_ROW_H;
            colorBackground[] = {0.04, 0.06, 0.10, 0.8};
            colorText[]       = {0.30, 0.70, 1.00, 0.9};
            sizeEx            = 0.025;
        };

        class Row5 : RscText {
            idc = 9012;
            text = "LINK STATUS: PENDING";
            x = TRC_X + TRC_MARGIN;  y = TRC_ROW5_Y;
            w = TRC_W - TRC_MARGIN*2;  h = TRC_ROW_H;
            colorBackground[] = {0.04, 0.06, 0.10, 0.8};
            colorText[]       = {0.30, 0.70, 1.00, 0.9};
            sizeEx            = 0.025;
        };

        class BtnClose : RscButtonMenuCancel {
            idc  = IDC_TRC_CLOSE;
            text = "CLOSE";
            x = TRC_BTN_R_X;  y = TRC_BTN_Y;
            w = TRC_BTN_W;    h = TRC_BTN_H;
            colorBackground[]       = {0.10, 0.12, 0.16, 1.0};
            colorBackgroundActive[] = {0.18, 0.22, 0.28, 1.0};
            colorText[]             = {0.75, 0.80, 0.85, 1};
            sizeEx                  = 0.039;
            onButtonClick = "closeDialog 2;";
        };
    };
};