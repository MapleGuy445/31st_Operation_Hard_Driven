// ============================================================
//  BOMB INPUT DIALOG (SCALED UP 1.5x)
// ============================================================
#define IDC_INPUT    100
#define IDC_CONFIRM  101
#define IDC_CANCEL   102

// Scaled bounds and re-centered
#define DLG_X  0.17
#define DLG_Y  0.08
#define DLG_W  0.66
#define DLG_H  0.84

// Scaled band heights
#define D_TITLE_H     0.078
#define D_SUB_H       0.054
#define D_DIVIDER_H   0.003
#define D_LABEL_H     0.048
#define D_INPUT_H     0.096
#define D_ROW_H       0.045
#define D_ROW_GAP     0.006
#define D_STATUS_H    0.048
#define D_FOOTER_H    0.045
#define D_BTN_H       0.087
#define D_BTN_W       0.291
#define D_MARGIN      0.018

// Top-down Y positions (scaled gaps)
#define D_TITLE_Y     DLG_Y
#define D_SUB_Y       D_TITLE_Y + D_TITLE_H
#define D_DIV1_Y      D_SUB_Y + D_SUB_H
#define D_LABEL_Y     D_DIV1_Y + D_DIVIDER_H + 0.009
#define D_INPUT_Y     D_LABEL_Y + D_LABEL_H + 0.006
#define D_ROWS_Y      D_INPUT_Y + D_INPUT_H + 0.012
#define D_ROW2_Y      D_ROWS_Y  + D_ROW_H + D_ROW_GAP
#define D_ROW3_Y      D_ROW2_Y  + D_ROW_H + D_ROW_GAP
#define D_ROW4_Y      D_ROW3_Y  + D_ROW_H + D_ROW_GAP
#define D_ROW5_Y      D_ROW4_Y  + D_ROW_H + D_ROW_GAP

// Bottom-up Y positions (scaled gaps)
#define D_FOOTER_Y    DLG_Y + DLG_H - D_FOOTER_H
#define D_STATUS_Y    D_FOOTER_Y - D_STATUS_H
#define D_DIV2_Y      D_STATUS_Y - D_DIVIDER_H
#define D_BTN_Y       D_DIV2_Y - D_BTN_H - 0.009

// Button X positions
#define D_BTN_L_X     DLG_X + D_MARGIN
#define D_BTN_R_X     DLG_X + DLG_W - D_MARGIN - D_BTN_W

class MyInputDialog {
    idd = 9001;
    movingEnable = false;
    enableSimulation = false;
    onUnload = "[(_this select 0), (_this select 1)] call MY_fnc_onDialogClose";

    class ControlsBackground {

        class Background : RscText {
            idc = -1;
            x = DLG_X;  y = DLG_Y;
            w = DLG_W;  h = DLG_H;
            colorBackground[] = {0.04, 0.04, 0.04, 0.97};
        };

        class TitleBar : RscText {
            idc = -1;
            text = "FURY TACTICAL NUCLEAR DEVICE INTERFACE";
            x = DLG_X;  y = D_TITLE_Y;
            w = DLG_W;  h = D_TITLE_H;
            colorBackground[] = {0.7, 0.05, 0.05, 1.0};
            colorText[]       = {1, 1, 1, 1};
            sizeEx            = 0.042; // Scaled font
        };

        class SubLabel : RscText {
            idc = -1;
            text = "ARMED  -  AWAITING AUTHORIZATION CODE";
            x = DLG_X;  y = D_SUB_Y;
            w = DLG_W;  h = D_SUB_H;
            colorBackground[] = {0.12, 0.04, 0.04, 0.97};
            colorText[]       = {0.85, 0.20, 0.20, 1};
            sizeEx            = 0.033; // Scaled font
        };

        class Divider1 : RscLine {
            idc = -1;
            x = DLG_X;  y = D_DIV1_Y;
            w = DLG_W;  h = D_DIVIDER_H;
            colorBackground[] = {0.7, 0.05, 0.05, 0.8};
        };

        class InputLabel : RscText {
            idc = -1;
            text = "ENTER DETONATION CODE:";
            x = DLG_X + D_MARGIN;  y = D_LABEL_Y;
            w = DLG_W - D_MARGIN*2;  h = D_LABEL_H;
            colorBackground[] = {0, 0, 0, 0};
            colorText[]       = {0.75, 0.75, 0.75, 1};
            sizeEx            = 0.033; // Scaled font
        };

        class Divider2 : RscLine {
            idc = -1;
            x = DLG_X;  y = D_DIV2_Y;
            w = DLG_W;  h = D_DIVIDER_H;
            colorBackground[] = {0.7, 0.05, 0.05, 0.8};
        };

        class StatusBar : RscText {
            idc = -1;
            text = "VERIFY CODE THEN CONFIRM DETONATION SEQUENCE";
            x = DLG_X;  y = D_STATUS_Y;
            w = DLG_W;  h = D_STATUS_H;
            colorBackground[] = {0.08, 0.02, 0.02, 0.97};
            colorText[]       = {0.50, 0.50, 0.50, 1};
            sizeEx            = 0.025; // Scaled font
        };

        class Footer : RscText {
            idc = -1;
            text = "UNAUTHORIZED ACCESS IS A COURT-MARTIAL OFFENSE";
            x = DLG_X;  y = D_FOOTER_Y;
            w = DLG_W;  h = D_FOOTER_H;
            colorBackground[] = {0.07, 0.02, 0.02, 0.97};
            colorText[]       = {0.38, 0.38, 0.38, 1};
            sizeEx            = 0.022; // Scaled font
        };
    };

    class Controls {

        class InputField : RscEdit {
            idc  = IDC_INPUT;
            text = "";
            x = DLG_X + D_MARGIN;  y = D_INPUT_Y;
            w = DLG_W - D_MARGIN*2;  h = D_INPUT_H;
            colorBackground[] = {0.06, 0.06, 0.06, 1.0};
            colorText[]       = {0.10, 1.0, 0.10, 1};
            colorSelection[]  = {0.7, 0.05, 0.05, 0.8};
            sizeEx            = 0.054; // Scaled font
        };

        class Row2 : RscText {
            idc = -1;
            text = "WARHEAD STATUS: ARMED  |  YIELD: 10 kT";
            x = DLG_X + D_MARGIN;  y = D_ROW2_Y;
            w = DLG_W - D_MARGIN*2;  h = D_ROW_H;
            colorBackground[] = {0.07, 0.07, 0.07, 0.8};
            colorText[]       = {0.10, 0.78, 0.10, 0.9};
            sizeEx            = 0.025; // Scaled font
        };

        class Row3 : RscText {
            idc = -1;
            text = "AUTHORIZATION LEVEL: ALPHA-1  |  AWAITING CODE";
            x = DLG_X + D_MARGIN;  y = D_ROW3_Y;
            w = DLG_W - D_MARGIN*2;  h = D_ROW_H;
            colorBackground[] = {0.07, 0.07, 0.07, 0.8};
            colorText[]       = {0.10, 0.78, 0.10, 0.9};
            sizeEx            = 0.025; // Scaled font
        };

        class Row4 : RscText {
            idc = -1;
            text = "DEFAULT TIMER : 120 seconds  |  COMM LINK: SECURE";
            x = DLG_X + D_MARGIN;  y = D_ROW4_Y;
            w = DLG_W - D_MARGIN*2;  h = D_ROW_H;
            colorBackground[] = {0.07, 0.07, 0.07, 0.8};
            colorText[]       = {0.10, 0.78, 0.10, 0.9};
            sizeEx            = 0.025; // Scaled font
        };

        class Row5 : RscText {
            idc = -1;
            text = "FAIL-SAFE: ACTIVE  |  RETRIES REMAINING: 3";
            x = DLG_X + D_MARGIN;  y = D_ROW5_Y;
            w = DLG_W - D_MARGIN*2;  h = D_ROW_H;
            colorBackground[] = {0.07, 0.07, 0.07, 0.8};
            colorText[]       = {0.10, 0.78, 0.10, 0.9};
            sizeEx            = 0.025; // Scaled font
        };

        class BtnConfirm : RscButtonMenu {
            idc  = IDC_CONFIRM;
            text = "DETONATE";
            x = D_BTN_L_X;  y = D_BTN_Y;
            w = D_BTN_W;     h = D_BTN_H;
            colorBackground[]        = {0.55, 0.04, 0.04, 1.0};
            colorBackgroundActive[]  = {0.78, 0.10, 0.10, 1.0};
            colorBackgroundDisabled[]= {0.28, 0.28, 0.28, 1.0};
            colorText[]              = {1, 1, 1, 1};
            sizeEx                   = 0.039; // Scaled font
            onButtonClick = "private _input = ctrlText ((findDisplay 9001) displayCtrl 100); [_input] call MY_fnc_handleInput; closeDialog 0;";
        };

        class BtnCancel : RscButtonMenuCancel {
            idc  = IDC_CANCEL;
            text = "ABORT";
            x = D_BTN_R_X;  y = D_BTN_Y;
            w = D_BTN_W;     h = D_BTN_H;
            colorBackground[]       = {0.16, 0.16, 0.16, 1.0};
            colorBackgroundActive[] = {0.28, 0.28, 0.28, 1.0};
            colorText[]             = {0.80, 0.80, 0.80, 1};
            sizeEx                  = 0.039; // Scaled font
            onButtonClick = "closeDialog 2;";
        };
    };
};