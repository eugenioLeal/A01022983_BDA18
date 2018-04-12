
// Importar JSON
mongoimport -h localhost:27017 -d clase -c partial --file ~/Downloads/grades.json;
-------------------------------------------------------------------------------------------------------------
Nota: para cada pregunta deberás resolverla utilizando
“aggregate framework”
“map-reduce”
-------------------------------------------------------------------------------------------------------------
Utiliza la base de datos GRADES.JSON para contestar las siguientes preguntas:
-------------------------------------------------------------------------------------------------------------
 1) ¿Cuál es el total de alumnos inscritos?
-------------------------------------------------------------------------------------------------------------
var mapFunction1 = function() {
  emit(this.student_id, 1);
};
var reduceFunction1 = function(student_id, values) {
  return Array.sum(values);
}
db.partial.mapReduce(
  mapFunction1,
  reduceFunction1,
  {
    out:"alumnosInscritos"
  }
)
-------------------------------------------------------------------------------------------------------------
 2) ¿Cuántos cursos se han impartido?
-------------------------------------------------------------------------------------------------------------

var mapFunction2 = function() {
  emit(this.class_id, 1);
};
var reduceFunction2 = function(classid, values) {
  return Array.sum(values);
};
db.partial.mapReduce(
  mapFunction2,
  reduceFunction2,
  {
    out:"cursos_impartidos"
  }
)
-------------------------------------------------------------------------------------------------------------
 3) Encuentra, para cada alumno, su promedio obtenido en cada una de las clases en las que fue inscrito (promedia exámenes, quizes, tareas y todas las actividades realizadas que contenga un grade)
-------------------------------------------------------------------------------------------------------------
var mapFunction3 = function() {
  this.scores.forEach((value)=>{
    emit({ class_id:this.class_id, student_id:this.student_id, num_scores:this.scores.length }, value.score);
  });
};
var reduceFunction3 = function(student, score) {
  return (Array.sum(score)/(student.num_scores)) ;
};
db.partial.mapReduce(
  mapFunction3,
  reduceFunction3,
  {
    out:"promedio_cada_clase"
  }
)



-------------------------------------------------------------------------------------------------------------
 4) ¿Cuál fue la materia que tiene la calificación más baja (muestra el id de la materia, el id del alumno y la calificación)? (promedio de calificación más baja)
-------------------------------------------------------------------------------------------------------------

// Primero tomamos en cueenta el map reduce del inciso 3)
var mapFunction3 = function() {
  this.scores.forEach((value)=>{
    emit({ class_id:this.class_id, student_id:this.student_id, num_scores:this.scores.length }, value.score);
  });
};
var reduceFunction3 = function(student, score) {
  return (Array.sum(score)/(student.num_scores)) ;
};
db.partial.mapReduce(
  mapFunction3,
  reduceFunction3,
  {
    out:"promedio_cada_clase"
  }
)

// Despues se realiza la consulta
db.promedio_cada_clase.find().sort({value:1}).limit(1);

-------------------------------------------------------------------------------------------------------------
 5) ¿Cuál es la materia en la que se han dejado más tareas?
-------------------------------------------------------------------------------------------------------------

// Usando aggregation pipeline
db.partial.aggregate([
  {
    $unwind: "$scores"
  },
  {
    $match: {
      "scores.type" : "homework"
    }
  },
  {
    $sortByCount : "$class_id"
  },
  {
    $sort: {
      count : -1
    }
  },
  {
    $limit: 1
  }
]).pretty()
-------------------------------------------------------------------------------------------------------------
 6) ¿Qué alumno se inscribió en más cursos?
-------------------------------------------------------------------------------------------------------------
// Se toma en cuenta el mapReduce del inciso 1)
var mapFunction1 = function() {
  emit(this.student_id, 1);
};
var reduceFunction1 = function(student_id, values) {
  return Array.sum(values);
}
db.partial.mapReduce(
  mapFunction1,
  reduceFunction1,
  {
    out:"alumnosInscritos"
  }
)

// Ejecutamos la consulta
db.alumno_en_mas_cursos.find().sort({value:-1}).limit(1).pretty()
-------------------------------------------------------------------------------------------------------------
 7) ¿Cuál fue el curso que tuvo más reprobados?
-------------------------------------------------------------------------------------------------------------
// Se toma en cuenta el mapReduce del inciso 3)
var mapFunction3 = function() {
  this.scores.forEach((value)=>{
    emit({ class_id:this.class_id, student_id:this.student_id, num_scores:this.scores.length }, value.score);
  });
};
var reduceFunction3 = function(student, score) {
  return (Array.sum(score)/(student.num_scores));
};
db.partial.mapReduce(
  mapFunction3,
  reduceFunction3,
  {
    out:"promedio_cada_clase"
  }
)

// Utilizando aggregation pipeline
db.promedio_cada_clase.aggregate([
  {
    $match : {
      value : { $lt : 70 }
    }
  },
  {
    $sortByCount : {
       "$_id.class_id"
    }
  }
])
-------------------------------------------------------------------------------------------------------------
Notas:
códigos similares equivalen a 0
el profesor no resuelve dudas (todo está en google)
