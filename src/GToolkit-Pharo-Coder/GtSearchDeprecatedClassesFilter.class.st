Class {
	#name : #GtSearchDeprecatedClassesFilter,
	#superclass : #GtSearchClassesFilter,
	#category : #'GToolkit-Pharo-Coder-Filters'
}

{ #category : #testing }
GtSearchDeprecatedClassesFilter >> includesClass: aClass [
	^ aClass isDeprecated
]
