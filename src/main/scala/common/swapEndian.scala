package sadie.common

import chisel3._
import chisel3.internal.naming.chiselName

object swapEndian {
  @chiselName
  def apply(x: Bits, width: Int): UInt = {
    val data = x.asUInt()
    return width match {
      case 32 => (data(7, 0) << 24.U) | (data(15, 8) << 16.U) | (data(23, 16) << 8.U) | data(31, 24)
      case 24 => (data(7, 0) << 16.U) | (data(15, 8) <<  8.U) |  data(23, 16)
      case 16 => (data(7, 0) <<  8.U) |  data(15, 8)
      case  8 => (data)
    }
  }
  def apply(data: Bits): UInt = apply(data, data.getWidth)
}
