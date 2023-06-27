Extension { #name : #Behavior }

{ #category : #'*GToolkit-Pharo-System' }
Behavior >> handleFailingBasicNew: sizeRequested [
	"handleFailingBasicNew: gets sent after basicNew: has failed and allowed
	 a scavenging garbage collection to occur.  The scavenging collection
	 will have happened as the VM is activating the (failing) basicNew:.  If
	 handleFailingBasicNew: fails then the scavenge failed to reclaim sufficient
	 space and a global garbage collection is required.  Retry after garbage
	 collecting and growing memory if necessary.

	 Primitive. Answer an instance of this class with the number of indexable
	 variables specified by the argument, sizeRequested.  Fail if this class is not
	 indexable or if the argument is not a positive Integer, or if there is not
	 enough memory available. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 71>
	| bytesRequested |
	bytesRequested := self byteSizeOfInstanceOfSize: sizeRequested.
	^Smalltalk garbageCollect < bytesRequested ifTrue:
		[Smalltalk growMemoryByAtLeast: bytesRequested.
		"retry after global garbage collect and possible grow"
		self handleFailingFailingBasicNew: sizeRequested]
	ifFalse:
		[self handleFailingBasicNewWithGC: sizeRequested]
]

{ #category : #'*GToolkit-Pharo-System' }
Behavior >> handleFailingBasicNewWithGC: sizeRequested [
	"handleFailingBasicNewWithGC: gets sent after basicNew: has failed, a GC has been
	performed and the allocation still fails even though enough memory was reported 
	as available. Given that this has happened when there is plenty of virtual memory available, assume that the GC has reported incorrectly and try one more time anyway.

	 Primitive. Answer an instance of this class with the number of indexable
	 variables specified by the argument, sizeRequested.  Fail if this class is not
	 indexable or if the argument is not a positive Integer, or if there is not
	 enough memory available. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 71>
	| bytesRequested |
	bytesRequested := self byteSizeOfInstanceOfSize: sizeRequested.
	Smalltalk growMemoryByAtLeast: bytesRequested.
	^self handleFailingFailingBasicNew: sizeRequested
]
