// kernel32.dart
//
// Dart representations of functions and constants used in kernel32.dll
//
// These functions are documented at:
//   https://docs.microsoft.com/en-us/windows/console/console-reference

import 'dart:ffi';

// *** CONSTANTS ***

const STD_INPUT_HANDLE = -10;
const STD_OUTPUT_HANDLE = -11;
const STD_ERROR_HANDLE = -12;

const INVALID_HANDLE_VALUE = -1;
const STATUS_INVALID_PARAMETER = 0xC000000D;

// input flags
const ENABLE_ECHO_INPUT = 0x0004;
const ENABLE_EXTENDED_FLAGS = 0x0080;
const ENABLE_INSERT_MODE = 0x0020;
const ENABLE_LINE_INPUT = 0x0002;
const ENABLE_MOUSE_INPUT = 0x0010;
const ENABLE_PROCESSED_INPUT = 0x0001;
const ENABLE_QUICK_EDIT_MODE = 0x0040;
const ENABLE_WINDOW_INPUT = 0x0008;
const ENABLE_VIRTUAL_TERMINAL_INPUT = 0x0200;

// output flags
const ENABLE_PROCESSED_OUTPUT = 0x0001;
const ENABLE_WRAP_AT_EOL_OUTPUT = 0x0002;
const ENABLE_VIRTUAL_TERMINAL_PROCESSING = 0x0004;
const DISABLE_NEWLINE_AUTO_RETURN = 0x0008;
const ENABLE_LVB_GRID_WORLDWIDE = 0x0010;

// *** FUNCTIONS ***

// BOOL WINAPI FillConsoleOutputCharacter(
//   _In_  HANDLE  hConsoleOutput,
//   _In_  TCHAR   cCharacter,
//   _In_  DWORD   nLength,
//   _In_  COORD   dwWriteCoord,
//   _Out_ LPDWORD lpNumberOfCharsWritten
// );
typedef fillConsoleOutputCharacterNative = Int8 Function(
    Int32 hConsoleOutput,
    Int8 cCharacter,
    Int32 nLength,
    Int32 dwWriteCoord,
    Pointer<Int32> lpNumberOfCharsWritten);
typedef fillConsoleOutputCharacterDart = int Function(
    int hConsoleOutput,
    int cCharacter,
    int nLength,
    int dwWriteCoord,
    Pointer<Int32> lpNumberOfCharsWritten);

// BOOL WINAPI FillConsoleOutputAttribute(
//   _In_  HANDLE  hConsoleOutput,
//   _In_  WORD    wAttribute,
//   _In_  DWORD   nLength,
//   _In_  COORD   dwWriteCoord,
//   _Out_ LPDWORD lpNumberOfAttrsWritten
// );
typedef fillConsoleOutputAttributeNative = Int8 Function(
    Int32 hConsoleOutput,
    Int16 wAttribute,
    Int32 nLength,
    Int32 dwWriteCoord,
    Pointer<Int32> lpNumberOfAttrsWritten);
typedef fillConsoleOutputAttributeDart = int Function(
    int hConsoleOutput,
    int cCharacter,
    int nLength,
    int dwWriteCoord,
    Pointer<Int32> lpNumberOfAttrsWritten);

// BOOL WINAPI GetConsoleScreenBufferInfo(
//   _In_  HANDLE                      hConsoleOutput,
//   _Out_ PCONSOLE_SCREEN_BUFFER_INFO lpConsoleScreenBufferInfo
// );
typedef getConsoleScreenBufferInfoNative = Int8 Function(Int32 hConsoleOutput,
    Pointer<CONSOLE_SCREEN_BUFFER_INFO> lpConsoleScreenBufferInfo);
typedef getConsoleScreenBufferInfoDart = int Function(int hConsoleOutput,
    Pointer<CONSOLE_SCREEN_BUFFER_INFO> lpConsoleScreenBufferInfo);

// _Post_equals_last_error_ DWORD GetLastError();
typedef getLastErrorNative = Int32 Function();
typedef getLastErrorDart = int Function();

// HANDLE WINAPI GetStdHandle(
//   _In_ DWORD nStdHandle
// );
typedef getStdHandleNative = Int32 Function(Int32 nStdHandle);
typedef getStdHandleDart = int Function(int nStdHandle);

// BOOL WINAPI SetConsoleCursorInfo(
//   _In_       HANDLE              hConsoleOutput,
//   _In_ const CONSOLE_CURSOR_INFO *lpConsoleCursorInfo
// );
typedef setConsoleCursorInfoNative = Int8 Function(
    Int32 hConsoleOutput, Pointer<CONSOLE_CURSOR_INFO> lpConsoleCursorInfo);
typedef setConsoleCursorInfoDart = int Function(
    int hConsoleOutput, Pointer<CONSOLE_CURSOR_INFO> lpConsoleCursorInfo);

// BOOL WINAPI SetConsoleCursorPosition(
//   _In_ HANDLE hConsoleOutput,
//   _In_ COORD  dwCursorPosition
// );
typedef setConsoleCursorPositionNative = Int8 Function(
    Int32 hConsoleOutput, Int32 dwCursorPosition);
typedef setConsoleCursorPositionDart = int Function(
    int hConsoleOutput, int dwCursorPosition);

// BOOL WINAPI SetConsoleMode(
//   _In_ HANDLE hConsoleHandle,
//   _In_ DWORD  dwMode
// );
typedef setConsoleModeNative = Int8 Function(
    Int32 hConsoleHandle, Int32 dwMode);
typedef setConsoleModeDart = int Function(int hConsoleHandle, int dwMode);

// *** STRUCTS ***

// Dart FFI does not yet have support for nested structs, so there's extra
// work necessary to unpack parameters like COORD and SMALL_RECT. The Dart
// issue for this work is https://github.com/dart-lang/sdk/issues/37271.

// typedef struct _CONSOLE_CURSOR_INFO {
//   DWORD dwSize;
//   BOOL  bVisible;
// } CONSOLE_CURSOR_INFO, *PCONSOLE_CURSOR_INFO;
class CONSOLE_CURSOR_INFO extends Struct<CONSOLE_CURSOR_INFO> {
  @Int32()
  int dwSize;
  @Int32()
  int bVisible;

  factory CONSOLE_CURSOR_INFO.allocate(int dwSize, int bVisible) =>
      Pointer<CONSOLE_CURSOR_INFO>.allocate().load<CONSOLE_CURSOR_INFO>()
        ..dwSize = dwSize
        ..bVisible = bVisible;
}

// typedef struct _CONSOLE_SCREEN_BUFFER_INFO {
//   COORD      dwSize;
//   COORD      dwCursorPosition;
//   WORD       wAttributes;
//   SMALL_RECT srWindow;
//   COORD      dwMaximumWindowSize;
// } CONSOLE_SCREEN_BUFFER_INFO;
class CONSOLE_SCREEN_BUFFER_INFO extends Struct<CONSOLE_SCREEN_BUFFER_INFO> {
  @Int16()
  int dwSizeX;

  @Int16()
  int dwSizeY;

  @Int16()
  int dwCursorPositionX;
  @Int16()
  int dwCursorPositionY;

  @Int16()
  int wAttributes;

  @Int16()
  int srWindowLeft;
  @Int16()
  int srWindowTop;
  @Int16()
  int srWindowRight;
  @Int16()
  int srWindowBottom;

  @Int16()
  int dwMaximumWindowSizeX;
  @Int16()
  int dwMaximumWindowSizeY;

  factory CONSOLE_SCREEN_BUFFER_INFO.allocate(
          COORD dwSize,
          COORD dwCursorPosition,
          int wAttributes,
          SMALL_RECT srWindow,
          COORD dwMaximumWindowSize) =>
      Pointer<CONSOLE_SCREEN_BUFFER_INFO>.allocate()
          .load<CONSOLE_SCREEN_BUFFER_INFO>()
            ..dwSizeX = dwSize.X
            ..dwSizeY = dwSize.Y
            ..dwCursorPositionX = dwCursorPosition.X
            ..dwCursorPositionY = dwCursorPosition.Y
            ..wAttributes = wAttributes
            ..srWindowLeft = srWindow.Left
            ..srWindowTop = srWindow.Top
            ..srWindowRight = srWindow.Right
            ..srWindowBottom = srWindow.Bottom
            ..dwMaximumWindowSizeX = dwMaximumWindowSize.X
            ..dwMaximumWindowSizeY = dwMaximumWindowSize.Y;
}

// typedef struct _COORD {
//   SHORT X;
//   SHORT Y;
// } COORD, *PCOORD;
class COORD extends Struct<COORD> {
  @Int16()
  int X;

  @Int16()
  int Y;

  factory COORD.allocate(int X, int Y) =>
      Pointer<COORD>.allocate().load<COORD>()
        ..X = X
        ..Y = Y;
}

// typedef struct _SMALL_RECT {
//   SHORT Left;
//   SHORT Top;
//   SHORT Right;
//   SHORT Bottom;
// } SMALL_RECT;
class SMALL_RECT extends Struct<SMALL_RECT> {
  @Int16()
  int Left;

  @Int16()
  int Top;

  @Int16()
  int Right;

  @Int16()
  int Bottom;
}