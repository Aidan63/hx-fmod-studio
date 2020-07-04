package hxfmod.studio;

enum abstract StudioLoadBankFlags(Int) from Int to Int
{
    var Normal = 0x00000000;
    var NonBlocking = 0x00000001;
    var DecompressSamples = 0x00000002;
    var Unencrypted = 0x00000004;
}