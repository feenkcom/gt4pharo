Class {
	#name : #GtCoderNavigationClassesHierarchyElementExamples,
	#superclass : #Object,
	#category : 'GToolkit-Pharo-Coder-Examples-Navigation'
}

{ #category : #examples }
GtCoderNavigationClassesHierarchyElementExamples >> emptyClassesHierarchy [
	<gtExample>
	| navigationModel classesElement |
	
	navigationModel := GtCoderNavigationPackagesTagsClassesModel new.
	
	classesElement := GtCoderNavigationClassHierarchyElement new.
	classesElement navigationModel: navigationModel.
	
	^ BlScripter new element: classesElement
]

{ #category : #examples }
GtCoderNavigationClassesHierarchyElementExamples >> selection_01_selectClass [
	<gtExample>
	| scripter |

	scripter := self emptyClassesHierarchy.
	
	scripter do
		action: [ :element |
			element navigationModel selectClass: GtCoderDummySuperclass ];
		play.

	^ scripter
]

{ #category : #examples }
GtCoderNavigationClassesHierarchyElementExamples >> selection_02_selectSubclass [
	<gtExample>
	| scripter |

	scripter := self selection_01_selectClass.
	
	scripter do
		action: [ :element |
			element navigationModel selectClass: GtCoderDummySubclass ];
		play.

	^ scripter
]
