Class {
	#name : #GtRecentChangesExamples,
	#superclass : #Object,
	#traits : 'TGtExampleAssertable',
	#classTraits : 'TGtExampleAssertable classTrait',
	#category : #'GToolkit-Pharo-Changes-Examples'
}

{ #category : #accessing }
GtRecentChangesExamples >> simpleChange [
	<gtExample>
	| change |
	change := GtRecentChanges new.
	
	self assert: change filterDescriptors size > 0.
	(change changedClasses size > 0) ifTrue: [
		self assert: change groupedChanges size equals: change changedClasses size.
	].
	
	^ change
]
