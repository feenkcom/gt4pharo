Class {
	#name : #GtBehaviorDefinitionCoderByScripterExamples,
	#superclass : #GtCoderByScripterExamples,
	#category : #'GToolkit-Pharo-Coder-Examples'
}

{ #category : #'examples - setup' }
GtBehaviorDefinitionCoderByScripterExamples >> behaviorDefinitionCoder [
	<gtExample>

	^ GtPharoBehaviorDefinitionCoder forBehavior: self targetClass
]

{ #category : #'examples - setup' }
GtBehaviorDefinitionCoderByScripterExamples >> behaviorDefinitionElement [
	<gtExample>
	| behaviorDefinitionCoder behaviorDefinitionElement |

	behaviorDefinitionCoder := self behaviorDefinitionCoder.
	behaviorDefinitionElement := behaviorDefinitionCoder asElement.

	^ behaviorDefinitionElement
]

{ #category : #examples }
GtBehaviorDefinitionCoderByScripterExamples >> behaviorDefinitionScripter [
	<gtExample>
	| aScripter |

	aScripter := self scripter.
	aScripter element: self behaviorDefinitionElement.

	^ aScripter
]

{ #category : #examples }
GtBehaviorDefinitionCoderByScripterExamples >> behaviorDefinitionScripter_CollapsedByDefault [
	<gtExample>
	| aScripter |
	aScripter := self behaviorDefinitionScripter.
	aScripter assert
		label: 'Assert that behavior definition is collapsed by default';
		satisfies: [ :aHeaderElement | aHeaderElement isCollapsed ];
		play.

	^ aScripter
]

{ #category : #examples }
GtBehaviorDefinitionCoderByScripterExamples >> behaviorDefinitionScripter_ExpandHeader [
	<gtExample>
	| aScripter |
	aScripter := self behaviorDefinitionScripter_CollapsedByDefault.
	aScripter
		substep: 'Expand behavior definition'
		do: [ :aStep | 
			aStep click
				label: 'Click on expand element';
				onChildAt: 1;
				play.
			aStep assert
				label: 'Assert behavior definition element is expanded';
				satisfies: [ :aBehaviorDefinition | aBehaviorDefinition isExpanded ];
				play ].

	^ aScripter
]

{ #category : #examples }
GtBehaviorDefinitionCoderByScripterExamples >> behaviorDefinitionScripter_ExpandHeader_CollapseHeader [
	<gtExample>
	| aScripter |
	aScripter := self behaviorDefinitionScripter_ExpandHeader.
	aScripter
		substep: 'Expand and collapse behavior definition'
		do: [ :aStep | 
			aStep click
				label: 'Click on expand element';
				onChildAt: 1;
				play.

			aStep assert
				label: 'Assert behavior definition element is collapsed';
				satisfies: [ :aBehaviorDefinition | aBehaviorDefinition isCollapsed ];
				play ].

	^ aScripter
]

{ #category : #accessing }
GtBehaviorDefinitionCoderByScripterExamples >> targetClass [
	^ GtBehaviorCoderDummyClass
]
