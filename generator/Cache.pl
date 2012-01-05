% model the generator's cache layer
%

% model *relations* between entities

% entities:
%   files: f1, f2, f3, ...
%   cache objects: co1, co2, co3, ...

:- dynamic cache/2, mtime/2.

mtime(f1, 100).
mtime(f2, 200).
mtime(f3, 200).
mtime(co1, 150).
mtime(co2, 200).
mtime(co3, 250).

is_fresh(CacheObject, FileObject):-
	mtime(CacheObject, T1),  % get the mtime of CacheObject
	mtime(FileObject, T2),
	T2 =< T1.

cache_read(CacheId, CmpFile, CacheObject):-
	cache(CacheId, CacheObject),
	is_fresh(CacheObject, CmpFile).

cache_write(CacheId, Content):-
	now_timestamp(Now),
	retract(mtime(Content, _)),
	assert(mtime(Content, Now)),
	retract(cache(CacheId, _)),
	assert(cache(CacheId, Content)).

now_timestamp(TS):-
	get_time(X),
	TS is floor(X).


