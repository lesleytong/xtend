package edu.ustb.sei.se.codegeneration

import org.eclipse.xtend.lib.annotations.Data
import java.util.List

@Data
class Entity {
	String name
	List<Feature> features
}