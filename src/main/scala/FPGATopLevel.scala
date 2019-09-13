package FPGA

import chisel3._
import chisel3.experimental.MultiIOModule

class FPGATopLevel() extends MultiIOModule {

  val io = IO(
    new Bundle {
      val spiPacketIn = Input(UInt(256.W))
    }
  )

  val debug = IO(
    new Bundle {
      val myDebugSignal = Output(Bool())
    }
  )


  /**
    * Your code here
    */
  val demuxSPI = Module(new Demultiplexer)
  val demuxGeneratorState = Module(new Demultiplexer)

  val volumeReg = RegInit(UInt(8.W), 0.U)
  val envelopeReg = Module(new Envelope)
  val pitchWheelReg = Module(new PitchWheelArray)

  val generatorStateDecoder = Module(new GeneratorStateDecoder())
  val globalStateDecoder = Module(new GlobalStateDecoder())


}
