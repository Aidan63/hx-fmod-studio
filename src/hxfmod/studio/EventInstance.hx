package hxfmod.studio;

class EventInstance
{
    final ptr : cpp.Star<NativeEventInstance>;

    public function new(_ptr : cpp.Pointer<NativeEventInstance>)
    {
        ptr = _ptr.ptr;
    }

    /**
     * Starts playback.
     * 
     * If the instance was already playing then calling this function will restart the event.
     * @return Result object.
     */
    public function start() : Result<Unit, Error>
    {
        final code = ptr.start();
        if (code == Ok)
        {
            return Success(Unit.value);
        }
        else
        {
            return Failure(code);
        }
    }

    /**
     * Stops playback.
     * @param _mode Stop mode.
     * @return Result object.
     */
    public function stop(_mode : StudioStopMode) : Result<Unit, Error>
    {
        final code = ptr.stop(cast _mode);
        if (code == Ok)
        {
            return Success(Unit.value);
        }
        else
        {
            return Failure(code);
        }
    }

    /**
     * Checks that the EventInstance reference is valid.
     * @return Bool
     */
    public function isValid() : Bool
    {
        return ptr.isValid();
    }

    /**
     * Marks the event instance for release.
     * 
     * This function marks the event instance to be released.
     * Event instances marked for release are destroyed by the asynchronous update when they are in the stopped state.
     * @return Result object.
     */
    public function release() : Result<Unit, Error>
    {
        final code = ptr.release();
        if (code == Ok)
        {
            return Success(Unit.value);
        }
        else
        {
            return Failure(code);
        }
    }

    /**
     * Sets a parameter value by name.
     * 
     * The value will be set instantly regardless of ignoreseekspeed when the Event playback state is `FMOD_STUDIO_PLAYBACK_STOPPED`.
     * 
     * If the specified parameter is an automatic parameter then `FMOD_ERR_INVALID_PARAM` is returned.
     * 
     * If the event has no parameter matching name then `FMOD_ERR_EVENT_NOTFOUND` is returned.
     * @param _name Parameter name (case-insensitive).
     * @param _value Value for given name.
     * @param _ignoreSeekSpeed Specifies whether to ignore the parameter's seek speed and set the value immediately.
     * @return Result<Unit, Error>
     */
    public function setParameterByName(_name : String, _value : Float, _ignoreSeekSpeed = false) : Result<Unit, Error>
    {
        final name = cpp.NativeString.c_str(_name);
        final code = ptr.setParameterByName(cast name.constRaw, _value, _ignoreSeekSpeed);
        if (code == Ok)
        {
            return Success(Unit.value);
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
@:native('FMOD::Studio::EventInstance')
extern class NativeEventInstance
{
    function start() : Error;

    function stop(_mode : NativeStopMode) : Error;

    function isValid() : Bool;

    function release() : Error;

    function setParameterByName(_name : cpp.ConstCharStar, _value : cpp.Float32, _ignoreSeekSpeed : Bool) : Error;
}

@:keep
@:unreflective
@:structAccess
@:native('FMOD_STUDIO_STOP_MODE')
private extern class NativeStopMode
{
    //
}