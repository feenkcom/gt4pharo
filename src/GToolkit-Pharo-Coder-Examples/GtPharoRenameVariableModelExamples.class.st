"
I contain examples of {{gtClass:GtPharoRenameVariableModel}} and {{gtClass:GtPharoRenameVariableValidator}}.
"
Class {
	#name : #GtPharoRenameVariableModelExamples,
	#superclass : #Object,
	#category : #'GToolkit-Pharo-Coder-Examples-Refactoring - Method New'
}

{ #category : #examples }
GtPharoRenameVariableModelExamples >> modelWithChangedName [
	<gtExample>
	<return: #GtPharoRenameVariableModel>
	| aModel anAnnouncement |
	aModel := self modelWithThreeOccurrences.
	aModel announcer
		weak
		when: GtPharoRenameVariableNameChanged
		do: [ :each | anAnnouncement := each ]
		for: self.
	aModel updateCurrentName: 'newValue' source: self.
	self assert: aModel currentName equals: 'newValue'.
	self assert: aModel originalName equals: 'value'.
	self assert: aModel isModified.
	self assert: aModel isValid.
	self assert: anAnnouncement currentName equals: 'newValue'.
	self assert: anAnnouncement isModified.
	self assert: anAnnouncement variableModel equals: aModel.
	self assert: anAnnouncement source equals: self.
	^ aModel
]

{ #category : #examples }
GtPharoRenameVariableModelExamples >> modelWithForbiddenName [
	<gtExample>
	<return: #GtPharoRenameVariableModel>
	| aModel |
	aModel := self modelWithThreeOccurrences.
	aModel validator forbiddenNames: #('existing').
	aModel updateCurrentName: 'existing' source: self.
	self assert: aModel isValid not.
	aModel updateCurrentName: 'free' source: self.
	self assert: aModel isValid.
	^ aModel
]

{ #category : #examples }
GtPharoRenameVariableModelExamples >> modelWithInvalidName [
	<gtExample>
	<return: #GtPharoRenameVariableModel>
	| aModel |
	aModel := self modelWithThreeOccurrences.
	#('' '1abc' 'a b' 'a:' '#a') do: [ :eachName | 
		aModel updateCurrentName: eachName source: self.
		self assert: aModel currentName equals: eachName.
		self assert: aModel isValid not description: eachName ].
	^ aModel
]

{ #category : #examples }
GtPharoRenameVariableModelExamples >> modelWithSameNameDoesNotAnnounce [
	<gtExample>
	<return: #GtPharoRenameVariableModel>
	| aModel aCount |
	aModel := self modelWithThreeOccurrences.
	aCount := 0.
	aModel announcer
		weak
		when: GtPharoRenameVariableNameChanged
		do: [ :each | aCount := aCount + 1 ]
		for: self.
	aModel updateCurrentName: 'value' source: self.
	self assert: aCount equals: 0.
	aModel updateCurrentName: 'other' source: self.
	aModel updateCurrentName: 'value' source: self.
	self assert: aCount equals: 2.
	self assert: aModel isModified not.
	^ aModel
]

{ #category : #examples }
GtPharoRenameVariableModelExamples >> modelWithThreeOccurrences [
	<gtExample>
	<return: #GtPharoRenameVariableModel>
	| aModel |
	aModel := GtPharoRenameVariableModel
			originalName: 'value'
			intervals: {5 to: 9.
					20 to: 24.
					30 to: 34}.
	self assert: aModel originalName equals: 'value'.
	self assert: aModel currentName equals: 'value'.
	self assert: aModel primaryInterval equals: (5 to: 9).
	self assert: aModel otherIntervals equals: {20 to: 24. 30 to: 34}.
	self assert: aModel isModified not.
	self assert: aModel isValid.
	^ aModel
]
