package hxfmod.studio;

enum abstract StudioInitFlags(Int) from Int to Int
{
    var Normal = 0x00000000;
    var LiveUpdate = 0x00000001;
    var AllowMissingPlugins = 0x00000002;
    var SynchronousUpdate = 0x00000004;
    var DeferredCallbacks = 0x00000008;
    var LoadFromUpdate = 0x00000010;
    var MemoryTracking = 0x00000020;
}