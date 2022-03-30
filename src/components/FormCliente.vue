<template>
  <div class="my-10">
    <form @submit.prevent="submit">
      <div class="shadow overflow-hidden sm:rounded-md">
        <div class="px-4 py-5 bg-white sm:p-6">
          <div class="grid grid-cols-6 gap-6">
            <div class="col-span-6 sm:col-span-3">
              <label for="nombre" class="block text-sm text-gray-700">Nombre</label>
              <input
                type="text"
                v-model="nombre"
                id="nombre"
                autocomplete="off"
                class="mt-1 block w-full shadow-sm sm:text-sm border-gray-700 rounded-md"
              />
            </div>                        
            <div class="col-span-6 sm:col-span-3">
              <label for="telefono" class="block text-sm text-gray-700">Telefono</label>
              <input
                type="text"
                v-model="telefono"
                id="telefono"
                autocomplete="off"
                class="mt-1 block w-full shadow-sm sm:text-sm border-gray-700 rounded-md"
              />
            </div>
          </div>
        </div>        
        <div class="px-4 py-3 bg-gray-50 text-right sm:px-6">
          <button
            type="submit"
            class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none"
          >
            Save
          </button>
        </div>
      </div>
    </form>
  </div>
  
  <div class="relative overflow-x-auto sm:rounded-lg">
    <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400" v-show="optionTable">
      <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
        <tr>
          <th scope="col" class="px-6 py-3">ID: {{ clientePagos.id }}</th>
          <th scope="col" class="px-6 py-3" colspan="2">NOMBRE: {{ clientePagos.nombre }}, Teléfono {{ clientePagos.telefono }}, Último pago: {{ clientePagos.ultimoPago }}</th>           
        </tr>
      </thead>
      <tbody>
        <tr class="bg-white border-b" v-for="(pago) in clientePagos.pagos" :key="pago.id">
          <th scope="row" class="px-6 py-4 whitespace-nowrap">{{ pago.id }}</th>
          <td class="px-6 py-4">{{ pago.monto }}</td>
          <td class="px-6 py-4">{{ pago.fechaPago }}</td>
        </tr>
      </tbody>
      <button @click="regresar" class="inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm rounded-md text-white bg-blue-600 hover:bg-blue-700 focus:outline-none">
        Regresar 
      </button>
    </table>

    <table class="w-full text-sm text-left text-gray-500 dark:text-gray-400" v-show="!optionTable">
      <thead class="text-xs text-gray-700 uppercase bg-gray-50 dark:bg-gray-700 dark:text-gray-400">
        <tr>
          <th scope="col" class="px-6 py-3">Nombre</th>
          <th scope="col" class="px-6 py-3">Telefono</th>           
        </tr>
      </thead>
      <tbody>
        <tr class="bg-white border-b click" v-for="(cliente) in clientes" :key="cliente.id" @click="consultarCliente(cliente.id)">          
          <td class="px-6 py-4">{{ cliente.nombre }}</td>
          <td class="px-6 py-4">{{ cliente.telefono }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import { ref, computed, onMounted } from "vue";

export default {
  name: "FormCliente",
  setup() {
    onMounted(() => {
        consultarClietnes()
    })
    const clientes = ref([])
    const clientePagos = ref([])
    const nombre = ref('')
    const telefono = ref('')
    const URLAPI = 'https://localhost:7066/api/Clientes/'
    const optionTable = ref(false)

    const consultarClietnes = async () => {        
        try {            
            const reqs = await fetch(URLAPI)
            const resp = await reqs.json()
            clientes.value = resp
            console.log(clientes.value);
        } catch (error) {            
            throw new Error(error)
        }
    }
    const consultarCliente = async (id) => {        
        try {            
            const reqs = await fetch(`${URLAPI}clientepagos/${id}`)
            const resp = await reqs.json()          
            console.log(resp);
            clientePagos.value = resp
            optionTable.value = true
        } catch (error) {            
            throw new Error(error)
        }
    }
    const regresar = () => {
        optionTable.value = false
    }
    const submit = () => {
      console.log("submit form");
    };

    return {
        nombre,
        telefono,
        clientes,
        optionTable,
        clientePagos,

        consultarCliente,
        regresar
    }
  },
};
</script>

<style scoped>
.click{
    cursor: pointer;
}
</style>