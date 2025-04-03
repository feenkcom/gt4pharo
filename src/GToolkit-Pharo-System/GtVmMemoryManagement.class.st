Class {
	#name : #GtVmMemoryManagement,
	#superclass : #Object,
	#instVars : [
		'growthHeadroom',
		'shrinkThreadshold',
		'fullGCRatio',
		'newSpaceSize',
		'maxOldSpaceSize',
		'minOldSpaceForGc'
	],
	#classVars : [
		'MinOldSpaceForGc'
	],
	#category : #'GToolkit-Pharo-System'
}

{ #category : #'memory management' }
GtVmMemoryManagement class >> dontGroupPinnedObjects [
	"Set the flag to avoid grouping pinned objects.
	For backward compatibility with VMs and images that don't support this flag, ignore errors"
	
	[ Smalltalk vm avoidSearchingSegmentsWithPinnedObjects: true ]
		on: PrimitiveFailed, MessageNotUnderstood
		do: [ :ex | "nothing" ]
]

{ #category : #'instance creation' }
GtVmMemoryManagement class >> forLargeObjectAllocation [

	"I create a configuration for executing the allocation of large objects as I expand the size of the new segments and the available space without executing a GC. Also I change the ratio to detect the execution of a Full GC, in this case the old space have to double itself before executing a FULL GC (grow a 100%)"

	^ self readFromVm
		growthHeadroom: 128 * 1024 * 1024;
		shrinkThreshhold: 100 * 1024 * 1024;
		fullGcRatio: 1.0;
		yourself.
]

{ #category : #initialization }
GtVmMemoryManagement class >> initialize [
	SessionManager default
		registerUserClassNamed: self name
]

{ #category : #accessing }
GtVmMemoryManagement class >> minOldSpaceForGc [

	MinOldSpaceForGc ifNil: [ ^ 0 ].
	^ MinOldSpaceForGc
]

{ #category : #accessing }
GtVmMemoryManagement class >> minOldSpaceForGc: anInteger [
	"Set the minimum old space size before garbage collecting when allocating new objects
	(see {{gtMethod:Behavior>>handleFailingBasicNew:}}."
	
	self validateMinOldSpaceForGc: anInteger.
	^ MinOldSpaceForGc := anInteger.
]

{ #category : #'instance creation' }
GtVmMemoryManagement class >> readFromVm [

	^ self new
		readFromVm;
		yourself.
]

{ #category : #initialization }
GtVmMemoryManagement class >> startUp: resuming [

	resuming ifTrue: [ self dontGroupPinnedObjects ]
]

{ #category : #accessing }
GtVmMemoryManagement class >> validateMinOldSpaceForGc: anInteger [
	"Validate the proposed value for MinOldSpaceForGc.
	The VM currently will abort if tenuring fails, which can be triggered by setting MaxOldSpaceSize and allowing old space to grow to that size.
	Having a MinOldSpaceSizeForGc >= MaxOldSpaceSize pretty much guarantees that the abort will be triggered,
	so don't allow it."
	| maxOldSpaceSize |

	maxOldSpaceSize := Smalltalk vm maxOldSpaceSize.
	(maxOldSpaceSize > 0 and: [ anInteger > (0.95 * maxOldSpaceSize) ]) ifTrue:
		[ self error: 'MinOldSpaceForGc must be less than maxOldSpace' ].
]

{ #category : #'from-to-the-vm' }
GtVmMemoryManagement >> activeDuring: aBlock [ 
	| old |

	old := self writeToVm.
	^ aBlock ensure: [ old writeToVm ]
]

{ #category : #accessing }
GtVmMemoryManagement >> fullGcRatio [
	^ fullGCRatio 
]

{ #category : #accessing }
GtVmMemoryManagement >> fullGcRatio: aNumber [ 
	fullGCRatio := aNumber
]

{ #category : #accessing }
GtVmMemoryManagement >> growthHeadroom [
	^ growthHeadroom
]

{ #category : #accessing }
GtVmMemoryManagement >> growthHeadroom: anInteger [ 
	growthHeadroom := anInteger
]

{ #category : #accessing }
GtVmMemoryManagement >> initialize [

	super initialize.
	minOldSpaceForGc := 0.
]

{ #category : #accessing }
GtVmMemoryManagement >> maxOldSpaceSize [

	^ maxOldSpaceSize
]

{ #category : #accessing }
GtVmMemoryManagement >> maxOldSpaceSize: anInteger [

	maxOldSpaceSize := anInteger
]

{ #category : #accessing }
GtVmMemoryManagement >> minOldSpaceForGc [
	"If old space is smaller than this value, old space growth is preferred over GC.
	nil = disabled"

	^ minOldSpaceForGc
]

{ #category : #accessing }
GtVmMemoryManagement >> minOldSpaceForGc: anInteger [

	self assert: anInteger isInteger
		description: 'minOldSpaceForGc must be an integer'.

	minOldSpaceForGc := anInteger.
]

{ #category : #accessing }
GtVmMemoryManagement >> newSpaceSize [

	^ newSpaceSize
]

{ #category : #accessing }
GtVmMemoryManagement >> newSpaceSize: anInteger [

	newSpaceSize := anInteger
]

{ #category : #'from-to-the-vm' }
GtVmMemoryManagement >> readFromVm [
	| vm |

	vm := Smalltalk vm.
	newSpaceSize := vm parameterAt: 45.
	maxOldSpaceSize := vm parameterAt: 67.
	growthHeadroom := vm parameterAt: 25. 
	shrinkThreadshold := vm parameterAt: 24.
	fullGCRatio := vm parameterAt: 55.
	minOldSpaceForGc := self class minOldSpaceForGc.
]

{ #category : #accessing }
GtVmMemoryManagement >> shrinkThreshhold [
	^ shrinkThreadshold
]

{ #category : #accessing }
GtVmMemoryManagement >> shrinkThreshhold: anInteger [ 
	shrinkThreadshold := anInteger
]

{ #category : #'from-to-the-vm' }
GtVmMemoryManagement >> writeToVm [
	| vm oldConfig oldNewSpaceSize oldGrowthHeadroom oldShrinkThreadshold oldFullGCRatio oldMaxOldSpaceSize oldMinOldSpaceForGc |

	vm := Smalltalk vm.
	oldConfig := self class new.

	oldMinOldSpaceForGc := self class minOldSpaceForGc.
	oldNewSpaceSize := vm parameterAt: 45 put: newSpaceSize.
	oldMaxOldSpaceSize := vm parameterAt: 67 put: maxOldSpaceSize.
	oldGrowthHeadroom := vm parameterAt: 25 put: growthHeadroom. 
	oldShrinkThreadshold := vm parameterAt: 24 put: shrinkThreadshold.
	oldFullGCRatio := vm parameterAt: 55 put: fullGCRatio asFloat.
	self class minOldSpaceForGc: minOldSpaceForGc.

	^ oldConfig
		newSpaceSize: oldNewSpaceSize;
		maxOldSpaceSize: oldMaxOldSpaceSize;
		growthHeadroom: oldGrowthHeadroom;
		shrinkThreshhold: oldShrinkThreadshold;
		fullGcRatio: oldFullGCRatio;
		minOldSpaceForGc: oldMinOldSpaceForGc;
		yourself.
]
