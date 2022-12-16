Extension { #name : #Behavior }

{ #category : #'*GToolkit-Pharo-Coder-UI' }
Behavior >> gtCopyButtonFor: anAction [
	<gtClassAction>
	^ anAction dropdown
		tooltip: 'Copy Class';
		icon: BrGlamorousVectorIcons changes;
		id: GtPharoCopyClassElementId;
		priority: 4;
		content: [ :aButton | 
			((GtCopyClassForm for: self)
				onAccept: [ :aClass | 
					aButton phlow spawnTool: (GtClassCoderTool forClass: aClass).
					aButton fireEvent: BrDropdownHideWish new ]) asElement
				padding: (BlInsets all: 5) ]
]
