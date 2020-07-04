package hxfmod;

enum Result<T, E>
{
    Success(data : T);
    Failure(error : E);
}