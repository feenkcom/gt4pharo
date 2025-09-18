Class {
	#name : #GtPushDownInstanceVariableRefactoring,
	#superclass : #RBPushDownInstanceVariableRefactoring,
	#category : #'GToolkit-Pharo-Coder-AddOns-Refactoring - Variables'
}

{ #category : #transforming }
GtPushDownInstanceVariableRefactoring >> basicTransform [
	class removeInstanceVariable: variableName.
	class subclasses
		do: [ :each | 
			(each withAllSubclasses
				anySatisfy: [ :cls | (cls whichSelectorsReferToInstanceVariable: variableName) notEmpty ])
				ifTrue: [ each addInstanceVariable: variableName ] ]
]

{ #category : #accessing }
GtPushDownInstanceVariableRefactoring >> preconditions [
	(class whichSelectorsReferToInstanceVariable: variableName) notEmpty
		ifTrue: [ GtRefactoringError
				signal: variableName , ' is referenced'
				withTag: [ :button | 
					| container selectorButton label |
					container := BrHorizontalPane new.
					container alignCenterLeft.
					container matchParent.
					selectorButton := BrButton new
							aptitude: BrGlamorousLinkSquaredButtonWithLabelAptitude new glamorousCodeFont;
							padding: (BlInsets all: 3);
							label: variableName asRopedText bold;
							action: [ button phlow
									spawnObject: ((GtSearchInstanceSlotReferenceFilter
											forClass: class realClass
											andVariable: variableName)
											includeSubclasses: false;
											yourself) ].
					label := BrLabel new
							fitContent;
							aptitude: BrGlamorousLabelAptitude new;
							padding: (BlInsets
									top: 3
									left: 0
									bottom: 3
									right: 3);
							text: 'is referenced in ' asRopedText glamorousRegularFontAndSize
									, class name asRopedText glamorousCodeFont.
					container addChild: selectorButton.
					container addChild: label.
					container ] ].
	^ RBCondition definesInstanceVariable: variableName in: class
]

{ #category : #transforming }
GtPushDownInstanceVariableRefactoring >> privateTransform [
	self basicTransform
]

{ #category : #transforming }
GtPushDownInstanceVariableRefactoring >> transform [
	self basicTransform
]
