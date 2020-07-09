package hxfmod.studio;

class Bus
{
    final ptr : cpp.Star<NativeBus>;

    public function new(_ptr : cpp.Pointer<NativeBus>)
    {
        ptr = _ptr.ptr;
    }

    public function setVolume(_volume : Float) : Error
    {
        return ptr.setVolume(_volume);
    }
}

@:keep
@:unreflective
@:structAccess
@:include('fmod_studio.hpp')
@:native('FMOD::Studio::Bus')
extern class NativeBus
{
    function setVolume(_volume : cpp.Float32) : Error;
}