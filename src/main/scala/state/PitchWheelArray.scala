package state

import chisel3._

class PitchWheelArray extends Bundle {

  val pitchWheelArray = UInt(128.W)

  def getPitchWheel(wheelNum: Int) = {
    pitchWheelArray(wheelNum+7, wheelNum*8)
  }

  val pitchWheelSelect = Array (
    0 -> pitchWheelArray(7, 0),
    1 -> pitchWheelArray(15, 8),
    2 -> pitchWheelArray(23, 16),
    3 -> pitchWheelArray(31, 24),
    4 -> pitchWheelArray(39, 32),
    5 -> pitchWheelArray(47, 40),
    6 -> pitchWheelArray(55, 48),
    7 -> pitchWheelArray(63, 56),
    8 -> pitchWheelArray(71, 64),
    9 -> pitchWheelArray(79, 72),
    10 -> pitchWheelArray(87, 80),
    11 -> pitchWheelArray(95, 88),
    12 -> pitchWheelArray(103, 96),
    13 -> pitchWheelArray(111, 104),
    14 -> pitchWheelArray(119, 112),
    15 -> pitchWheelArray(127, 120),
  )

}
