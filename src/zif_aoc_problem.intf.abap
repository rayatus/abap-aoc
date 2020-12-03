interface ZIF_AOC_PROBLEM
  public .


  methods SET_INPUT
    importing
      !IO_INPUT_HELPER type ref to ZIF_AOC_INPUT_HELPER .
  methods RUN .
  methods PRINT
    importing
      !IO_OUT type ref to IF_DEMO_OUTPUT .
endinterface.
