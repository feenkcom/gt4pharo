Extension { #name : #Behavior }

{ #category : #'*GToolkit-Pharo-System' }
Behavior >> handleFailingBasicNew [
	"handleFailingBasicNew gets sent after basicNew has failed and allowed
	 a scavenging garbage collection to occur.  The scavenging collection
	 will have happened as the VM is activating the (failing) basicNew.  If
	 handleFailingBasicNew fails then the scavenge failed to reclaim sufficient
	 space and a global garbage collection is required.  Retry after garbage
	 collecting and growing memory if necessary.

	 Primitive. Answer an instance of this class with the number of indexable
	 variables specified by the argument, sizeRequested.  Fail if this class is not
	 indexable or if the argument is not a positive Integer, or if there is not
	 enough memory available. Essential. See Object documentation whatIsAPrimitive."

	<primitive: 70>
	Smalltalk vm oldSpace < self minOldSpaceForGc ifTrue:
		[ Smalltalk growMemoryByAtLeast: 1048576 ]
	ifFalse: [ Smalltalk garbageCollect < 1048576 ifTrue:
		[ Smalltalk growMemoryByAtLeast: 1048576 ] ].
	^self handleFailingFailingBasicNew
]

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
	<gtPharoPatch: #Pharo>
	| bytesRequested |
	bytesRequested := self byteSizeOfInstanceOfSize: sizeRequested.
	^ Smalltalk vm oldSpace < self minOldSpaceForGc ifTrue:
		[ Smalltalk growMemoryByAtLeast: bytesRequested.
		self handleFailingFailingBasicNew: sizeRequested ]
	ifFalse: [ Smalltalk garbageCollect < bytesRequested ifTrue:
		[Smalltalk growMemoryByAtLeast: bytesRequested.
		self handleFailingFailingBasicNew: sizeRequested]
	ifFalse:
		[self handleFailingBasicNewWithGC: sizeRequested] ]
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
	Stdio stdout lf; << 'GtGc: Extra growth: '; print: bytesRequested; lf.
	^ [ Smalltalk growMemoryByAtLeast: bytesRequested.
		self handleFailingFailingBasicNew: sizeRequested ]
			valueUnpreemptively.
]

{ #category : #'*GToolkit-Pharo-System' }
Behavior >> minOldSpaceForGc [
	"Answer the value below which old space will be grown instead of garbage collecting"

	^ [ | minOldSpaceForGc |
	minOldSpaceForGc := GtVmMemoryManagement minOldSpaceForGc.
	minOldSpaceForGc isInteger 
		ifTrue: [ minOldSpaceForGc ]
		ifFalse: [ 0 ] ]
			on: Error
			do: [ :ex | 0 ]
]

{ #category : #'*GToolkit-Pharo-System' }
Behavior >> recompile: selector from: oldClass [
	"Compile the method associated with selector in the receiver's method dictionary."

	"Recompilation should be done silently, to avoid putting noise in the system"
	GtPharoCodeModifier current critical:
	[ | method newMethod source debugging |
	debugging := Dictionary new.
	SystemAnnouncer uniqueInstance localSuspendWhile: 
		[ method := oldClass compiledMethodAt: selector.
		newMethod := oldClass compiler
			source: (oldClass sourceCodeAt: selector);
			priorMethod: method;
			class: self;
			permitFaulty: true;
			logged: false;
			install	"No need to log recompilation in the sources,
				 	 We are going to reuse the original source pointer." ].

	source := newMethod sourceCodeOrNil.
	source ifNotNil:
		[ source := source first: (200 min: source size) ].
	debugging 
		at: #newSource put: source;
		at: #newSelector put: newMethod selector.
	newMethod sourcePointer: method sourcePointer.
	selector == newMethod selector ifFalse: 
		[ source := method sourceCodeOrNil.
		source ifNotNil:
			[ source := source first: (200 min: source size) ].
		debugging 
			at: #selector put: selector;
			at: #oldMethod put: method;
			at: #newMethod put: newMethod;
			at: #oldSource put: source;
			at: #sourcePointer put: method sourcePointer.
		self signalSelectorChanged: debugging ] ]
]

{ #category : #'*GToolkit-Pharo-System' }
Behavior >> signalSelectorChanged: debuggingInfo [
	| associations message |

	associations := debuggingInfo associations sorted: #key ascending.
	message := String streamContents: [ :stream |
		stream
			<< 'Selector changed during compilation'; cr.
		associations do: [ :assoc |
			stream
				<< assoc key asString; cr;
				<< assoc value asString; cr;
				cr. ].
		].
	self error: message.
]
