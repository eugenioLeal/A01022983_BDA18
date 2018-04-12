// Importar JSON
mongoimport -h localhost:27017 -d clase -c partial --file ~/Downloads/grades.json;

Nota: para cada pregunta deberás resolverla utilizando
“aggregate framework”
“map-reduce”
Utiliza la base de datos GRADES.JSON para contestar las siguientes preguntas:
-------------------------------------------------------------------------------------------------------------
¿Cuál es el total de alumnos inscritos?
-------------------------------------------------------------------------------------------------------------
var mapFunction1 = function() {
  emit(this.student_id, 1);
};
var reduceFunction1 = function(studentid, values) {
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
¿Cuántos cursos se han impartido?
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
Encuentra, para cada alumno, su promedio obtenido en cada una de las clases en las que fue inscrito (promedia exámenes, quizes, tareas y todas las actividades realizadas que contenga un grade)
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
¿Cuál fue la materia que tiene la calificación más baja (muestra el id de la materia, el id del alumno y la calificación)? (promedio de calificación más baja)
-------------------------------------------------------------------------------------------------------------
db.promedio_cada_clase.find().sort({value:1}).limit(1);

var mapFunction4 = function() {
  var minScore = 100000000000;
  this.scores.forEach((value)=>{
    if(value.score < minScore) {
      minScore = value.score;
    }
  });
  emit({ class_id:this.class_id, student_id:this.student_id}, minScore);
};
var reduceFunction4 = function(obj, minScore) {
  return minScore;
};
db.partial.mapReduce(
  mapFunction4,
  reduceFunction4,
  {
    out:"materia_calificacion_mas_baja"
  }
)

-------------------------------------------
var mapFunction4 = function() {
  this.scores.forEach((value)=>{
    emit({ class_id:this.class_id, student_id:this.student_id, num_scores:this.scores.length }, value.score);
  });
};
var reduceFunction4 = function(student, score) {
  return (Array.sum(score)/(student.num_scores)) ;
};
db.partial.mapReduce(
  mapFunction4,
  reduceFunction4,
  {
    out:"promedio_cada_clase"
  }
)
-------------------------------------------------------------------------------------------------------------
¿Cuál es la materia en la que se han dejado más tareas?
-------------------------------------------------------------------------------------------------------------
var mapFunction5 = function() {
  var num_homeworks = 0;
  this.scores.forEach((value)=>{
    if(value.type === "homework") {
      num_homeworks++;
    }
  });
  emit(this.class_id, num_homeworks);
};
var reduceFunction5 = function(class_id, num_homeworks) {
  return num_homeworks;
};
db.partial.mapReduce(
  mapFunction5,
  reduceFunction5,
  {
    out:"materia_mas_tareas"
  }
)
-------------------------------------------------------------------------------------------------------------
¿Qué alumno se inscribió en más cursos?
-------------------------------------------------------------------------------------------------------------
var mapFunction6 = function() {
  emit(this.student_id, this.class_id);
};
var reduceFunction6 = function() {
  return
};
db.partial.mapReduce(
  mapFunction6,
  reduceFunction6,
  {
    out:""
  }
)

db.partial.aggregate(
   [
     {
       $group:
         {
           _id: "$student_id",
           maxCursos: { $max: {  } },
           maxQuantity: { $max: "$quantity" }
         }
     }
   ]
)

-------------------------------------------------------------------------------------------------------------
¿Cuál fue el curso que tuvo más reprobados?
-------------------------------------------------------------------------------------------------------------
var mapFunction7 = function() {
};
var reduceFunction7 = function() {
};
db.partial.mapReduce(
  mapFunction7,
  reduceFunction7,
  {
    out:""
  }
)
-------------------------------------------------------------------------------------------------------------
Notas:
códigos similares equivalen a 0
el profesor no resuelve dudas (todo está en google)
