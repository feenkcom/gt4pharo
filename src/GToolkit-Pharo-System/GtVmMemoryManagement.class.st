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

{ #category : #'instance creation' }
GtVmMemoryManagement class >> forLargeObjectAllocation [

	"I create a configuration for executing the allocation of large objects as I expand the size of the new segments and the available space without executing a GC. Also I change the ratio to detect the execution of a Full GC, in this case the old space have to double itself before executing a FULL GC (grow a 100%)"

	^ self readFromVM
		growthHeadroom: 128 * 1024 * 1024;
		shrinkThreadshold: 100 * 1024 * 1024;
		fullGCRatio: 1.0;
		yourself.
]

{ #category : #accessing }
GtVmMemoryManagement class >> minOldSpaceForGc [

	MinOldSpaceForGc ifNil: [ ^ 0 ].
	self validateMinOldSpaceForGc: MinOldSpaceForGc.
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
GtVmMemoryManagement class >> readFromVM [

	^ self new
		readFromVM;
		yourself.
]

{ #category : #accessing }
GtVmMemoryManagement class >> validateMinOldSpaceForGc: anInteger [
	"Validate the proposed value for MinOldSpaceForGc.
	The VM currently will abort if tenuring fails, which can be triggered by setting MaxOldSpaceSize and allowing old space to grow to that size.
	Having a MinOldSpaceSizeForGc >= MaxOldSpaceSize pretty much guarantees that the abort will be triggered,
	so don't allow it."
	
	anInteger > (0.95 * Smalltalk vm maxOldSpaceSize) ifTrue:
		[ self error: 'MinOldSpaceForGc must be less than maxOldSpace' ].
]

{ #category : #'from-to-the-vm' }
GtVmMemoryManagement >> activeDuring: aBlock [ 
	| old |

	old := self writeToVM.
	aBlock ensure: [ old writeToVM ]
]

{ #category : #accessing }
GtVmMemoryManagement >> fullGCRatio [
	^ fullGCRatio 
]

{ #category : #accessing }
GtVmMemoryManagement >> fullGCRatio: aNumber [ 
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
GtVmMemoryManagement >> readFromVM [
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
GtVmMemoryManagement >> shrinkThreadshold [
	^ shrinkThreadshold
]

{ #category : #accessing }
GtVmMemoryManagement >> shrinkThreadshold: anInteger [ 
	shrinkThreadshold := anInteger
]

{ #category : #'from-to-the-vm' }
GtVmMemoryManagement >> writeToVM [
	| vm oldConfig oldNewSpaceSize oldGrowthHeadroom oldShrinkThreadshold oldFullGCRatio oldMaxOldSpaceSize oldMinOldSpaceForGc |

	vm := Smalltalk vm.
	oldConfig := self class new.

	oldNewSpaceSize := vm parameterAt: 45 put: newSpaceSize.
	oldMaxOldSpaceSize := vm parameterAt: 67 put: maxOldSpaceSize.
	oldGrowthHeadroom := vm parameterAt: 25 put: growthHeadroom. 
	oldShrinkThreadshold := vm parameterAt: 24 put: shrinkThreadshold.
	oldFullGCRatio := vm parameterAt: 55 put: fullGCRatio asFloat.
	oldMinOldSpaceForGc := self class minOldSpaceForGc.
	self class minOldSpaceForGc: minOldSpaceForGc.
	
	^ oldConfig
		newSpaceSize: oldNewSpaceSize;
		maxOldSpaceSize: oldMaxOldSpaceSize;
		growthHeadroom: oldGrowthHeadroom;
		shrinkThreadshold: oldShrinkThreadshold;
		fullGCRatio: oldFullGCRatio;
		minOldSpaceForGc: oldMinOldSpaceForGc;
		yourself.
]
