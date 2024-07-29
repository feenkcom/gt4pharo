Class {
	#name : #GtVmMemoryManagementExamples,
	#superclass : #Object,
	#instVars : [
		'previousConfiguration'
	],
	#category : #'GToolkit-Pharo-System'
}

{ #category : #examples }
GtVmMemoryManagementExamples >> growWithoutGc [
	"Demonstrate growing old space up to the limit without a GC.
	Avoid locking up the host machine if it is low on RAM by not running the example.
	Answer a boolean indicating if the example was really run."
	"<gtExample>"
	| mbCount testConfig vm m512 startFullGcCount endFullGcCount startGrowCount endGrowCount expectedGrowCount freeOldSpace oldSpaceSize headroom |

	mbCount := 512.
	m512 := mbCount * (1024 ** 2).
	GtOsSystemInfo current freeMemory < m512 ifTrue:
		[ ^ false ].

	vm := Smalltalk vm.
	testConfig := GtVmMemoryManagement readFromVM.
	(testConfig maxOldSpaceSize > 0 and: [ testConfig maxOldSpaceSize - vm oldSpace < m512 ]) ifTrue:
		[ testConfig maxOldSpaceSize: vm oldSpace + (2 * m512) ].
	testConfig minOldSpaceForGc: vm oldSpace + (1.5 * m512) rounded.
	testConfig activeDuring:
		[ | arrays |
		startFullGcCount := vm fullGCCount.
		startGrowCount := vm parameterAt: 31.
		freeOldSpace := ((vm parameterAt: 54) / (1024 ** 2)) truncated.
		oldSpaceSize := vm parameterAt: 1.
		headroom := (vm parameterAt: 25) / (1024 ** 2).
		"Calculate roughly the number of times old space will grow.
		The minimum growth is headroom MB."
		expectedGrowCount := (((mbCount - freeOldSpace) max: 0) / headroom) truncated.
		arrays := OrderedCollection new.
		"Force the array in to old space by pinning"
		mbCount timesRepeat: 
			[ arrays add: (ByteArray newPinned: 1024 ** 2).
			arrays last unpinInMemory ].
		endFullGcCount := vm fullGCCount.
		endGrowCount := vm parameterAt: 31.
		arrays := nil ].

	self assert: endFullGcCount equals: startFullGcCount.
	self assert: (endGrowCount - startGrowCount) >= expectedGrowCount.
	^ true
]

{ #category : #'tests - writing to the VM' }
GtVmMemoryManagementExamples >> testActiveDuring [
	<gtExample>
	| new old vm |

	vm := Smalltalk vm.
	new := GtVmMemoryManagement readFromVM.
	old := GtVmMemoryManagement readFromVM.

	new growthHeadroom: new growthHeadroom * 4.
	new shrinkThreadshold: new shrinkThreadshold * 4.	
	new fullGCRatio: new fullGCRatio * 4.
	new newSpaceSize: new newSpaceSize * 2.
	new maxOldSpaceSize: new maxOldSpaceSize * 2.
	new minOldSpaceForGc: new minOldSpaceForGc + 100000.
	
	new activeDuring: 
		[ self assert: new growthHeadroom equals: (vm parameterAt: 25).
		self assert: new shrinkThreadshold equals: (vm parameterAt: 24).
		self assert: new fullGCRatio equals: (vm parameterAt: 55).
		self assert: new newSpaceSize equals: (vm parameterAt: 45).
		self assert: new maxOldSpaceSize equals: (vm parameterAt: 67).
		self assert: new minOldSpaceForGc equals: GtVmMemoryManagement minOldSpaceForGc ].

	self assert: (vm parameterAt: 25) equals: old growthHeadroom.
	self assert: (vm parameterAt: 24) equals: old shrinkThreadshold.
	self assert: (vm parameterAt: 55) equals: old fullGCRatio.
	self assert: (vm parameterAt: 45) equals: old newSpaceSize.
	self assert: (vm parameterAt: 67) equals: old maxOldSpaceSize.
	self assert: GtVmMemoryManagement minOldSpaceForGc equals: old minOldSpaceForGc.
]

{ #category : #'tests - reading from VM' }
GtVmMemoryManagementExamples >> testReadingFromVmFullGcRatioIsAFloat [
	<gtExample>
	| conf |

	conf := GtVmMemoryManagement readFromVM.
	self assert: conf fullGCRatio isFloat.
]

{ #category : #'tests - reading from VM' }
GtVmMemoryManagementExamples >> testReadingFromVmFullGcRatioMatchesValue [
	<gtExample>
	| conf |

	conf := GtVmMemoryManagement readFromVM.
	self assert: conf fullGCRatio equals: (Smalltalk vm parameterAt: 55). 
]

{ #category : #'tests - reading from VM' }
GtVmMemoryManagementExamples >> testReadingFromVmGrowthHeadroomMatchesValue [
	<gtExample>
	| conf |

	conf := GtVmMemoryManagement readFromVM.
	self assert: conf growthHeadroom equals: (Smalltalk vm parameterAt: 25). 
]

{ #category : #'tests - reading from VM' }
GtVmMemoryManagementExamples >> testReadingFromVmNewSpaceSizeMatchesValue [
	<gtExample>
	| conf |

	conf := GtVmMemoryManagement readFromVM.
	self assert: conf newSpaceSize equals: (Smalltalk vm parameterAt: 45). 
]

{ #category : #'tests - reading from VM' }
GtVmMemoryManagementExamples >> testReadingFromVmShrinkThreadsholdMatchesValue [
	<gtExample>
	| conf |

	conf := GtVmMemoryManagement readFromVM.
	self assert: conf shrinkThreadshold equals: (Smalltalk vm parameterAt: 24). 
]

{ #category : #'tests - writing to the VM' }
GtVmMemoryManagementExamples >> testWritingReturnsTheOldConfigurationWithFullGCRatio [
	<gtExample>
	| conf old oldValue|
	conf := GtVmMemoryManagement readFromVM.
	oldValue := Smalltalk vm parameterAt: 55.
	
	conf fullGCRatio: conf fullGCRatio * 4.
	old := conf writeToVM.
	self assert: old fullGCRatio equals: oldValue. 
]

{ #category : #'tests - writing to the VM' }
GtVmMemoryManagementExamples >> testWritingReturnsTheOldConfigurationWithNewSpaceSize [
	<gtExample>
	| conf old oldValue|

	conf := GtVmMemoryManagement readFromVM.
	oldValue := Smalltalk vm parameterAt: 45.

	conf newSpaceSize: conf newSpaceSize * 4.
	old := conf writeToVM.
	self assert: old newSpaceSize equals: oldValue. 
]

{ #category : #'tests - writing to the VM' }
GtVmMemoryManagementExamples >> testWritingUpdatesFullGcRatio [
	<gtExample>
	| conf old |
	conf := GCConfiguration readFromVM.
	
	conf fullGCRatio: conf fullGCRatio * 4.
	old := conf writeToVM.
	self assert: conf fullGCRatio equals: (Smalltalk vm parameterAt: 55). 
]

{ #category : #'tests - writing to the VM' }
GtVmMemoryManagementExamples >> testWritingUpdatesNewSpaceSize [
	<gtExample>
	| conf old oldValue|

	conf := GtVmMemoryManagement readFromVM.
	oldValue := Smalltalk vm parameterAt: 45.
	conf newSpaceSize: conf newSpaceSize * 4.
	old := conf writeToVM.
	self assert: conf newSpaceSize equals: (Smalltalk vm parameterAt: 45). 
]
