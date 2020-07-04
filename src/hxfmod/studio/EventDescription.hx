package hxfmod.studio;

import hxfmod.studio.EventInstance.NativeEventInstance;

class EventDescription
{
    final ptr : cpp.Star<NativeEventDescription>;

    public function new(_ptr : cpp.Pointer<NativeEventDescription>)
    {
        ptr = _ptr.ptr;
    }

    /**
     * Creates a playable instance.
     * 
     * When an event instance is created, any required non-streaming sample data is loaded asynchronously.
     * 
     * Use `Studio::EventDescription::getSampleLoadingState` to check the loading status.
     * 
     * Sample data can be loaded ahead of time with `Studio::EventDescription::loadSampleData` or `Studio::Bank::loadSampleData`.
     * See Sample Data Loading for more information.
     * @return Result object.
     */
    public function createInstance() : Result<EventInstance, Error>
    {
        final inst : cpp.Star<NativeEventInstance> = null;
        final code = ptr.createInstance(cpp.Native.addressOf(inst));

        if (code == Ok)
        {
            return Success(new EventInstance(cpp.Pointer.fromStar(inst)));
        }
        else
        {
            return Failure(code);
        }
    }

    /**
     * Retrieves the path.
     * 
     * The strings bank must be loaded prior to calling this function, otherwise `EventNotFound` is returned.
     * 
     * If the path is longer than size then it is truncated and this function returns `Truncated`.
     * @return Result object.
     */
    public function getPath() : Result<String, Error>
    {
        untyped __cpp__('char str[100]');
        final size = 0;
        final code = ptr.getPath(untyped str, 100, cpp.Native.addressOf(size));

        if (code == Ok)
        {
            return Success(cpp.NativeString.fromPointerLen(untyped str, size));
        }
        else
        {
            return Failure(code);
        }
    }
}

@:keep
@:unreflective
@:structAccess
@:include('fmod_studio.hpp')
@:native('FMOD::Studio::EventDescription')
extern class NativeEventDescription
{
    function createInstance(_ptr : cpp.Star<cpp.Star<NativeEventInstance>>) : Error;

    function getPath(_path : cpp.Star<cpp.Char>, _size : Int, _retrieved : cpp.Star<Int>) : Error;
}