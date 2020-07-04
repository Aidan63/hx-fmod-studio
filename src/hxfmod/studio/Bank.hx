package hxfmod.studio;

import hxfmod.studio.EventDescription.NativeEventDescription;

class Bank
{
    final ptr : cpp.Star<NativeBank>;

    public function new(_ptr : cpp.Pointer<NativeBank>)
    {
        ptr = _ptr.ptr;
    }

    /**
     * This will destroy all objects created from the bank, unload all sample data inside the bank, and invalidate all API handles referring to the bank.
     * 
     * If the bank was loaded from user-managed memory, e.g. by `Studio::System::loadBankMemory` with the `FMOD_STUDIO_LOAD_MEMORY_POINT` mode, then the memory must not be freed until the unload has completed.
     * Poll the loading state using `Studio::Bank::getLoadingState` or use the `FMOD_STUDIO_SYSTEM_CALLBACK_BANK_UNLOAD` system callback to determine when it is safe to free the memory.
     * @return Result object.
     */
    public function unload() : Result<Unit, Error>
    {
        final code = ptr.unload();
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
     * Use this function to preload sample data ahead of time so that the events in the bank can play immediately when started.
     * 
     * This function is equivalent to calling `Studio::EventDescription::loadSampleData` for all events in the bank, including referenced events.
     */
    public function loadSampleData() : Result<Unit, Error>
    {
        final code = ptr.loadSampleData();
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
     * Unloads non-streaming sample data for all events in the bank.
     * 
     * Sample data loading is reference counted and the sample data will remain loaded until unload requests corresponding to all load requests are made, or until the bank is unloaded.
     */
    public function unloadSampleData() : Result<Unit, Error>
    {
        final code = ptr.unloadSampleData();
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
     * Retrieves the number of event descriptions in the bank.
     * 
     * May be used in conjunction with `Studio::Bank::getEventList` to enumerate the events in the bank.
     * 
     * This function counts the events which were added to the bank by the sound designer.
     * The bank may contain additional events which are referenced by event instruments but were not added to the bank, and those referenced events are not counted.
     * @return Result object.
     */
    public function getEventCount() : Result<Int, Error>
    {
        final count = 0;
        final code  = ptr.getEventCount(cpp.Native.addressOf(count));

        if (code == Ok)
        {
            return Success(count);
        }
        else
        {
            return Failure(code);
        }
    }

    /**
     * Retrieves a list of the event descriptions in the bank.
     * 
     * This function returns a maximum of capacity events from the bank. If the bank contains more than capacity events then additional events will be silently ignored.
     * 
     * May be used in conjunction with `Studio::Bank::getEventCount` to enumerate the events in the bank.
     * 
     * This function retrieves the events which were added to the bank by the sound designer.
     * The bank may contain additional events which are referenced by event instruments but were not added to the bank, and those referenced events are not retrieved.
     * @param _capacity maximum capacity of the array.
     * @return Result object.
     */
    public function getEventList(_capacity : Int) : Result<Array<EventDescription>, Error>
    {
        untyped __cpp__('std::vector<FMOD::Studio::EventDescription*> array({0})', _capacity);

        final count = 0;
        final code  = ptr.getEventList(untyped __cpp__('array.data()'), _capacity, cpp.Native.addressOf(count));
        final out   = [];

        if (code == Ok)
        {
            for (i in 0...count)
            {
                out.push(new EventDescription(cpp.Pointer.fromStar(untyped __cpp__('array[{0}]', i))));
            }
    
            return Success(out);
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
@:native('FMOD::Studio::Bank')
extern class NativeBank
{
    function unload() : Error;

    function loadSampleData() : Error;

    function unloadSampleData() : Error;

    function getEventCount(_count : cpp.Star<Int>) : Error;

    function getEventList(_array : cpp.Star<cpp.Star<NativeEventDescription>>, _capacity : Int, _count : cpp.Star<Int>) : Error;
}