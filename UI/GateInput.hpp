// ============================================================
//  GATE TURRET CONTROL CONSOLE
// ============================================================
#define IDC_GATE_INPUT    110
#define IDC_GATE_CONFIRM  111
#define IDC_GATE_CANCEL   112

#define GATE_X  0.17
#define GATE_Y  0.08
#define GATE_W  0.66
#define GATE_H  0.84

// Band heights
#define GATE_TITLE_H    0.078
#define GATE_SUB_H      0.054
#define GATE_DIVIDER_H  0.003
#define GATE_LABEL_H    0.048
#define GATE_INPUT_H    0.096
#define GATE_ROW_H      0.045
#define GATE_ROW_GAP    0.006
#define GATE_STATUS_H   0.048
#define GATE_FOOTER_H   0.045
#define GATE_BTN_H      0.087
#define GATE_BTN_W      0.291
#define GATE_MARGIN     0.018

// Top-down Y positions
#define GATE_TITLE_Y    GATE_Y
#define GATE_SUB_Y      GATE_TITLE_Y + GATE_TITLE_H
#define GATE_DIV1_Y     GATE_SUB_Y + GATE_SUB_H
#define GATE_LABEL_Y    GATE_DIV1_Y + GATE_DIVIDER_H + 0.009
#define GATE_INPUT_Y    GATE_LABEL_Y + GATE_LABEL_H + 0.006
#define GATE_ROWS_Y     GATE_INPUT_Y + GATE_INPUT_H + 0.012
#define GATE_ROW2_Y     GATE_ROWS_Y + GATE_ROW_H + GATE_ROW_GAP
#define GATE_ROW3_Y     GATE_ROW2_Y + GATE_ROW_H + GATE_ROW_GAP
#define GATE_ROW4_Y     GATE_ROW3_Y + GATE_ROW_H + GATE_ROW_GAP
#define GATE_ROW5_Y     GATE_ROW4_Y + GATE_ROW_H + GATE_ROW_GAP

// Bottom-up Y positions
#define GATE_FOOTER_Y   GATE_Y + GATE_H - GATE_FOOTER_H
#define GATE_STATUS_Y   GATE_FOOTER_Y - GATE_STATUS_H
#define GATE_DIV2_Y     GATE_STATUS_Y - GATE_DIVIDER_H
#define GATE_BTN_Y      GATE_DIV2_Y - GATE_BTN_H - 0.009

// Button X
#define GATE_BTN_L_X    GATE_X + GATE_MARGIN
#define GATE_BTN_R_X    GATE_X + GATE_W - GATE_MARGIN - GATE_BTN_W

class GateConsole {
    idd = 9003;
    movingEnable = false;
    enableSimulation = false;
    onLoad   = "(_this select 0) call MY_fnc_gateConsoleLoad";
    onUnload = "[(_this select 0), (_this select 1)] call MY_fnc_gateConsoleClose";

    class ControlsBackground {

        class Background : RscText {
            idc = -1;
            x = GATE_X;  y = GATE_Y;
            w = GATE_W;  h = GATE_H;
            colorBackground[] = {0.03, 0.04, 0.05, 0.97};
        };

        class TitleBar : RscText {
            idc = -1;
            text = "FACILITY GATE CONTROL SYSTEM";
            x = GATE_X;  y = GATE_TITLE_Y;
            w = GATE_W;  h = GATE_TITLE_H;
            colorBackground[] = {0.05, 0.20, 0.40, 1.0};
            colorText[]       = {1, 1, 1, 1};
            sizeEx            = 0.042;
        };

        class SubLabel : RscText {
            // Text is set dynamically from SQF based on current turret state
            text = "LOADING...";
            idc = 9010;
            x = GATE_X;  y = GATE_SUB_Y;
            w = GATE_W;  h = GATE_SUB_H;
            colorBackground[] = {0.04, 0.10, 0.18, 0.97};
            colorText[]       = {0.30, 0.65, 1.00, 1};
            sizeEx            = 0.033;
        };

        class Divider1 : RscLine {
            idc = -1;
            x = GATE_X;  y = GATE_DIV1_Y;
            w = GATE_W;  h = GATE_DIVIDER_H;
            colorBackground[] = {0.10, 0.40, 0.80, 0.8};
        };

        class InputLabel : RscText {
            idc = -1;
            text = "ENTER AUTHORIZATION CODE:";
            x = GATE_X + GATE_MARGIN;  y = GATE_LABEL_Y;
            w = GATE_W - GATE_MARGIN*2;  h = GATE_LABEL_H;
            colorBackground[] = {0, 0, 0, 0};
            colorText[]       = {0.70, 0.80, 0.90, 1};
            sizeEx            = 0.033;
        };

        class Divider2 : RscLine {
            idc = -1;
            x = GATE_X;  y = GATE_DIV2_Y;
            w = GATE_W;  h = GATE_DIVIDER_H;
            colorBackground[] = {0.10, 0.40, 0.80, 0.8};
        };

        class StatusBar : RscText {
            idc = -1;
            text = "ENTER CODE AND CONFIRM TO UNLOCK GATE";
            x = GATE_X;  y = GATE_STATUS_Y;
            w = GATE_W;  h = GATE_STATUS_H;
            colorBackground[] = {0.04, 0.07, 0.12, 0.97};
            colorText[]       = {0.45, 0.55, 0.65, 1};
            sizeEx            = 0.025;
        };

        class Footer : RscText {
            idc = -1;
            text = "UNAUTHORIZED ACCESS WILL BE REPORTED TO COMMAND";
            x = GATE_X;  y = GATE_FOOTER_Y;
            w = GATE_W;  h = GATE_FOOTER_H;
            colorBackground[] = {0.03, 0.05, 0.09, 0.97};
            colorText[]       = {0.32, 0.38, 0.45, 1};
            sizeEx            = 0.022;
        };
    };

    class Controls {

        class InputField : RscEdit {
            idc  = IDC_GATE_INPUT;
            text = "";
            x = GATE_X + GATE_MARGIN;  y = GATE_INPUT_Y;
            w = GATE_W - GATE_MARGIN*2;  h = GATE_INPUT_H;
            colorBackground[] = {0.04, 0.06, 0.10, 1.0};
            colorText[]       = {0.30, 0.80, 1.00, 1};
            colorSelection[]  = {0.10, 0.40, 0.80, 0.8};
            sizeEx            = 0.054;
        };

        // Status readout rows
        class Row1 : RscText {
            idc = -1;
            text = "SYSTEM: GATE CONTROL GRID";
            x = GATE_X + GATE_MARGIN;  y = GATE_ROWS_Y;
            w = GATE_W - GATE_MARGIN*2;  h = GATE_ROW_H;
            colorBackground[] = {0.04, 0.06, 0.10, 0.8};
            colorText[]       = {0.30, 0.70, 1.00, 0.9};
            sizeEx            = 0.025;
        };

        // Turret name — set dynamically from SQF
        class Row2 : RscText {
            idc = 9011;
            text = "GATE ID: LOADING...";
            x = GATE_X + GATE_MARGIN;  y = GATE_ROW2_Y;
            w = GATE_W - GATE_MARGIN*2;  h = GATE_ROW_H;
            colorBackground[] = {0.04, 0.06, 0.10, 0.8};
            colorText[]       = {0.30, 0.70, 1.00, 0.9};
            sizeEx            = 0.025;
        };

        // Current state — set dynamically from SQF
        class Row5 : RscText {
            idc = 9012;
            text = "CURRENT STATE: LOADING...";
            x = GATE_X + GATE_MARGIN;  y = GATE_ROW5_Y;
            w = GATE_W - GATE_MARGIN*2;  h = GATE_ROW_H;
            colorBackground[] = {0.04, 0.06, 0.10, 0.8};
            colorText[]       = {0.30, 0.70, 1.00, 0.9};
            sizeEx            = 0.025;
        };

        class BtnConfirm : RscButtonMenu {
            idc  = IDC_GATE_CONFIRM;
            text = "CONFIRM";
            x = GATE_BTN_L_X;  y = GATE_BTN_Y;
            w = GATE_BTN_W;    h = GATE_BTN_H;
            colorBackground[]        = {0.05, 0.25, 0.50, 1.0};
            colorBackgroundActive[]  = {0.10, 0.40, 0.75, 1.0};
            colorBackgroundDisabled[]= {0.20, 0.20, 0.20, 1.0};
            colorText[]              = {1, 1, 1, 1};
            sizeEx                   = 0.039;
            onButtonClick =
                "private _input = ctrlText ((findDisplay 9003) displayCtrl 110); [_input] call MY_fnc_gateHandleInput; closeDialog 0;";
        };

        class BtnCancel : RscButtonMenuCancel {
            idc  = IDC_GATE_CANCEL;
            text = "CANCEL";
            x = GATE_BTN_R_X;  y = GATE_BTN_Y;
            w = GATE_BTN_W;    h = GATE_BTN_H;
            colorBackground[]       = {0.10, 0.12, 0.16, 1.0};
            colorBackgroundActive[] = {0.18, 0.22, 0.28, 1.0};
            colorText[]             = {0.75, 0.80, 0.85, 1};
            sizeEx                  = 0.039;
            onButtonClick = "closeDialog 2;";
        };
    };
};