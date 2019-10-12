package sadie.toplevel

import Ex0.TestUtils._
import chisel3.{printf=>_, _}
import chisel3.iotesters.PeekPokeTester
import org.scalatest.{FlatSpec, Matchers}
import sadie.communication.{GeneratorUpdatePacket,GlobalUpdatePacket}
import sadie.toplevel.GeneratorUpdatePacketTest._

class GlobalUpdatePacketDecoder extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(256.W))
    val out = Output(new GlobalUpdatePacket)
  })
  io.out := io.in.asTypeOf(new GlobalUpdatePacket).withEndianSwapped()
}

class GeneratorUpdatePacketDecoder extends Module {
  val io = IO(new Bundle {
    val in = Input(UInt(256.W))
    val out = Output(new GeneratorUpdatePacket)
  })
  io.out := io.in.asTypeOf(new GeneratorUpdatePacket).withEndianSwapped()
}

class PacketDecodeTest extends FlatSpec with Matchers {
  behavior of "Decoders"
  it should "Decode Global Packets Correctly" in {
    wrapTester(
      chisel3.iotesters.Driver(() => new GlobalUpdatePacketDecoder()) { c =>
        new GlobalStateDecoderTest(c)
      } should be(true)
    )
  }

  it should "Decode Generator Packets Correctly" in {
    wrapTester(
      chisel3.iotesters.Driver(() => new GeneratorUpdatePacketDecoder()) { c =>
        new GeneratorStateDecoderTest(c)
      } should be(true)
    )
  }
}

object GeneratorUpdatePacketTest {
  val rand = new scala.util.Random(100)

  class GlobalStateDecoderTest(c: GlobalUpdatePacketDecoder) extends PeekPokeTester(c) {

    poke(c.io.in, BigInt("017FE406742299742200010203040506070809101112131415", 16))
    step(1)

    printf("packet.magic:                  0x%02x\n", peek(c.io.out.magic))
    printf("packet.data.volume:            0x%02x\n", peek(c.io.out.data.volume))
    printf("packet.data.envelope.attack:   0x%02x\n", peek(c.io.out.data.envelope.attack))
    printf("packet.data.envelope.decay:    0x%02x\n", peek(c.io.out.data.envelope.decay))
    printf("packet.data.envelope.sustain:  0x%02x\n", peek(c.io.out.data.envelope.sustain))
    printf("packet.data.envelope.release:  0x%02x\n", peek(c.io.out.data.envelope.release))
    printf("packet.data.pitchwheels(0):    0x%02x\n", peek(c.io.out.data.pitchwheels(0)))
    printf("packet.data.pitchwheels(1):    0x%02x\n", peek(c.io.out.data.pitchwheels(1)))
    printf("packet.data.pitchwheels(2):    0x%02x\n", peek(c.io.out.data.pitchwheels(2)))
    printf("packet.data.pitchwheels(3):    0x%02x\n", peek(c.io.out.data.pitchwheels(3)))
    printf("packet.data.pitchwheels(4):    0x%02x\n", peek(c.io.out.data.pitchwheels(4)))
    printf("packet.data.pitchwheels(5):    0x%02x\n", peek(c.io.out.data.pitchwheels(5)))
    printf("packet.data.pitchwheels(6):    0x%02x\n", peek(c.io.out.data.pitchwheels(6)))
    printf("packet.data.pitchwheels(7):    0x%02x\n", peek(c.io.out.data.pitchwheels(7)))
    printf("packet.data.pitchwheels(8):    0x%02x\n", peek(c.io.out.data.pitchwheels(8)))
    printf("packet.data.pitchwheels(9):    0x%02x\n", peek(c.io.out.data.pitchwheels(9)))
    printf("packet.data.pitchwheels(10):   0x%02x\n", peek(c.io.out.data.pitchwheels(10)))
    printf("packet.data.pitchwheels(11):   0x%02x\n", peek(c.io.out.data.pitchwheels(11)))
    printf("packet.data.pitchwheels(12):   0x%02x\n", peek(c.io.out.data.pitchwheels(12)))
    printf("packet.data.pitchwheels(13):   0x%02x\n", peek(c.io.out.data.pitchwheels(13)))
    printf("packet.data.pitchwheels(14):   0x%02x\n", peek(c.io.out.data.pitchwheels(14)))
    printf("packet.data.pitchwheels(15):   0x%02x\n", peek(c.io.out.data.pitchwheels(15)))
    expect(c.io.out.magic,                 1)
    expect(c.io.out.data.volume,           0x7f)
    expect(c.io.out.data.envelope.attack,  0x06E4)
    expect(c.io.out.data.envelope.decay,   0x2274)
    expect(c.io.out.data.envelope.sustain, 0x99)
    expect(c.io.out.data.envelope.release, 0x2274)
    expect(c.io.out.data.pitchwheels(0),   0x00)
    expect(c.io.out.data.pitchwheels(1),   0x01)
    expect(c.io.out.data.pitchwheels(2),   0x02)
    expect(c.io.out.data.pitchwheels(3),   0x03)
    expect(c.io.out.data.pitchwheels(4),   0x04)
    expect(c.io.out.data.pitchwheels(5),   0x05)
    expect(c.io.out.data.pitchwheels(5),   0x05)
    expect(c.io.out.data.pitchwheels(6),   0x06)
    expect(c.io.out.data.pitchwheels(7),   0x07)
    expect(c.io.out.data.pitchwheels(8),   0x08)
    expect(c.io.out.data.pitchwheels(9),   0x09)
    expect(c.io.out.data.pitchwheels(10),  0x10)
    expect(c.io.out.data.pitchwheels(11),  0x11)
    expect(c.io.out.data.pitchwheels(12),  0x12)
    expect(c.io.out.data.pitchwheels(13),  0x13)
    expect(c.io.out.data.pitchwheels(14),  0x14)
    expect(c.io.out.data.pitchwheels(15),  0x15)

  }

  class GeneratorStateDecoderTest(c: GeneratorUpdatePacketDecoder) extends PeekPokeTester(c) {

    poke(c.io.in, BigInt("0250400101efbeadde2E0f64", 16))
    step(1)
    printf("packet.magic:               0x%02x\n", peek(c.io.out.magic))
    printf("packet.generator_index:     0x%02x\n", peek(c.io.out.generator_index))
    printf("packet.data.reset_note:     %b\n", peek(c.io.out.data.reset_note))
    printf("packet.data.enabled:        %b\n", peek(c.io.out.data.enabled))
    printf("packet.data.instrument:     0x%02x\n", peek(c.io.out.data.instrument))
    printf("packet.data.note_index:     0x%02x\n", peek(c.io.out.data.note_index))
    printf("packet.data.channel_index:  0x%02x\n", peek(c.io.out.data.channel_index))
    printf("packet.data.velocity:       0x%02x\n", peek(c.io.out.data.velocity))
    expect(c.io.out.magic,              2)
    expect(c.io.out.generator_index,    0x4050)
    expect(c.io.out.data.reset_note,    true)
    expect(c.io.out.data.enabled,       true)
    expect(c.io.out.data.instrument,    BigInt("deadbeef", 16))
    expect(c.io.out.data.note_index,    46)
    expect(c.io.out.data.channel_index, 15)
    expect(c.io.out.data.velocity,      100)

  }
}
