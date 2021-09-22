Extension { #name : 'ClassDescription' }

{ #category : '*GToolkit-Pharo-Coder-UI' }
ClassDescription >> gtCoderSlotNames [
	"Answer the slot names to be bound by GtPharoSourceCoderViewModel.
	By default, this is all the slots in the object, however proxies may want to override this to display a different set (e.g. none)."

	^ self slotNames
]
