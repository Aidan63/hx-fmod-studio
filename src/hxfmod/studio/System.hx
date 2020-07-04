package hxfmod.studio;

import haxe.io.Bytes;
import hxfmod.studio.Bank;
import hxfmod.studio.EventDescription;

class System
{
    final ptr : cpp.Star<NativeSystem>;

    function new(_ptr : cpp.Pointer<NativeSystem>)
    {
        ptr = _ptr.ptr;
    }

    /**
     * FMOD Studio System creation function.
     */
    public static function create() : Result<System, Error>
    {
        final sys : cpp.Star<NativeSystem> = null;

        final code = NativeSystem.create(cpp.Native.addressOf(sys));
        if (code == Ok)
        {
            return Success(new System(cpp.Pointer.fromStar(sys)));
        }
        else
        {
            return Failure(code);
        }
    }

    /**
     * Initializes the Studio System.
     * @param _maxChannels The maximum number of channels to be used in FMOD.
     * @param _studioFlags Studio system initialization flags. `FMOD_STUDIO_INITFLAGS`
     * @param _flags Core system initialization flags. `FMOD_INITFLAGS`
     * @return Result object.
     */
    public function initialize(_maxChannels : Int, _studioFlags : StudioInitFlags, _flags : InitFlags) : Result<Unit, Error>
    {
        final code = ptr.initialize(_maxChannels, _studioFlags, _flags, null);
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
     * Checks that the System reference is valid and has been initialized.
     */
    public function isValid() : Bool
    {
        return ptr.isValid();
    }

    /**
     * Update the FMOD Studio System.
     * 
     * When Studio is initialized in the default asynchronous processing mode this function submits all buffered commands for execution on the Studio Update thread for asynchronous processing.
     * This is a fast operation since the commands are not processed on the calling thread.
     * If Studio is initialized with `FMOD_STUDIO_INIT_DEFERRED_CALLBACKS` then any deferred callbacks fired during any asynchronous updates since the last call to this function will be called.
     * If an error occurred during any asynchronous updates since the last call to this function then this function will return the error result.
     * 
     * When Studio is initialized with `FMOD_STUDIO_INIT_SYNCHRONOUS_UPDATE` queued commands will be processed immediately when calling this function, the scheduling and update logic for the Studio system are executed and all callbacks are fired.
     * This may block the calling thread for a substantial amount of time.
     * 
     * @return Result object.
     */
    public function update() : Result<Unit, Error>
    {
        final code = ptr.update();
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
     * Shut down and free the Studio System object.
     * This function will free the memory used by the Studio System object and everything created under it.
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
     * Loads the metadata of a Studio bank from file.
     * 
     * Sample data must be loaded separately see Sample Data Loading for details.
     * By default this function will block until the file load finishes and return the `FMOD_RESULT` indicating the result.
     * If the load fails then bank will contain NULL.
     * 
     * Using the `FMOD_STUDIO_LOAD_BANK_NONBLOCKING` flag will cause the bank to be loaded asynchronously.
     * In that case this function will always return `FMOD_OK` and bank will contain a valid bank handle.
     * Load errors for asynchronous banks can be detected by calling `Studio::Bank::getLoadingState`.
     * Failed asynchronous banks should be released by calling `Studio::Bank::unload`.
     * @param _filename Name of the file on disk.
     * @param _flags Flags to control bank loading. `FMOD_STUDIO_LOAD_BANK_FLAGS`
     * @return Result object.
     */
    public function loadBankFile(_filename : String, _flags : StudioLoadBankFlags) : Result<Bank, Error>
    {
        final bnk : cpp.Star<NativeBank> = null;
        final code = ptr.loadBankFile(_filename, _flags, cpp.Native.addressOf(bnk));
        if (code == Ok)
        {
            return Success(new Bank(cpp.Pointer.fromStar(bnk)));
        }
        else
        {
            return Failure(code);
        }
    }

    /**
     * Loads the metadata of a Studio bank from memory.
     * @param _bytes Bytes byffer
     * @param _length Length of the buffer
     * @param _mode Loading mode to use. `FMOD_STUDIO_LOAD_MEMORY_MODE`
     * @param _flags Flags to control bank loading. `FMOD_STUDIO_LOAD_BANK_FLAGS`
     * @return Result object.
     */
    public function loadBankMemory(_bytes : Bytes, _length : Int, _mode : StudioLoadMemoryMode, _flags : StudioLoadBankFlags) : Result<Bank, Error>
    {
        final bnk : cpp.Star<NativeBank> = null;
        final code = ptr.loadBankMemory(cast cpp.Pointer.arrayElem(_bytes.getData(), 0).ptr, _length, cast _mode, _flags, cpp.Native.addressOf(bnk));

        if (code == Ok)
        {
            return Success(new Bank(cpp.Pointer.fromStar(bnk)));
        }
        else
        {
            return Failure(code);
        }
    }

    /**
     * Retrieves an EventDescription.
     * 
     * This function allows you to retrieve a handle to any loaded event description.
     * 
     * path may be a path, such as `event:/UI/Cancel` or `snapshot:/IngamePause`, or an ID string, such as `{2a3e48e6-94fc-4363-9468-33d2dd4d7b00}`.
     * 
     * Note that path lookups will only succeed if the strings bank has been loaded.
     * @param _path The path or the ID string that identifies the event or snapshot.
     * @return Result object.
     */
    public function getEvent(_path : String) : Result<EventDescription, Error>
    {
        final desc : cpp.Star<NativeEventDescription> = null;
        final code = ptr.getEvent(_path, cpp.Native.addressOf(desc));

        if (code == Ok)
        {
            return Success(new EventDescription(cpp.Pointer.fromStar(desc)));
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
@:native('FMOD::Studio::System')
#if !display
@:build(hxfmod.macros.Setup.touch())
@:build(hxfmod.macros.Setup.xml())
#end
extern class NativeSystem
{
    @:native('FMOD::Studio::System::create')
    static function create(_system : cpp.Star<cpp.Star<NativeSystem>>) : Error;

    function initialize(_maxChannels : Int, _studioFlags : Int, _flags : Int, _extraDriverData : cpp.Star<cpp.Void>) : Error;

    function isValid() : Bool;

    function update() : Error;

    function release() : Error;

    function loadBankFile(_file : cpp.ConstCharStar, _flags : Int, _bank : cpp.Star<cpp.Star<NativeBank>>) : Error;

    function loadBankMemory(_buffer : cpp.ConstCharStar, _length : Int, _mode : NativeMemoryLoadMode, _flags : Int, _bank : cpp.Star<cpp.Star<NativeBank>>) : Error;

    function getEvent(_path : cpp.ConstCharStar, _event : cpp.Star<cpp.Star<NativeEventDescription>>) : Error;
}

@:keep
@:unreflective
@:structAccess
@:native('FMOD_STUDIO_LOAD_MEMORY_MODE')
private extern class NativeMemoryLoadMode
{

}
