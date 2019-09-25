package state

import chisel3._

class PitchWheelArray extends Bundle {

  val pitchWheelArray = UInt(128.W)

  def getPitchWheel(wheelNum: Int) = {
    pitchWheelArray(wheelNum+7, wheelNum*8)
  }
}
