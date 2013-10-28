# language: es
@javascript

Característica: Crear nueva denuncia

Antecedentes:
  Dado que cuento con un catálogo de dependencias

Escenario: Visualizar formulario de denuncia
  Dado que visito la página de inicio
  Cuando doy click en el enlace "Deseo realizar una denuncia"
  Entonces debo visualizar el formulario de denuncia

Escenario: Crear nueva denuncia
  Dado que visito la página de crear denuncia
  Cuando capturo la información de la denuncia
  Entonces debo visualizar el mensaje "El número de folio asignado a tu Queja o Denuncia es"

Escenario: Crear nueva denuncia con imágenes adjuntas
  Dado que visito la página de crear denuncia
  Cuando capturo la información de la denuncia y adjunto imágenes
  Entonces debo visualizar el mensaje "El número de folio asignado a tu Queja o Denuncia es"

Escenario: Crear nueva denuncia con archivos adjuntos
  Dado que visito la página de crear denuncia
  Cuando capturo la información de la denuncia y adjunto archivos
  Entonces debo visualizar el mensaje "La denuncia no pudo guardarse"

Escenario: Limpiar formulario de denuncia
  Dado que visito la página de crear denuncia
  Cuando capturo la información de la denuncia y elijo la opción 'Limpiar'
  Entonces el formulario se debe mostrar vacío
