<template>
  <div class="my-10">
    <form @submit.prevent="submit">
      <div class="shadow overflow-hidden sm:rounded-md">
        <div class="px-4 py-5 bg-white sm:p-6">
          <div class="grid grid-cols-6 gap-6">
            <div class="col-span-6 sm:col-span-3">
              <label for="nombre" class="block text-sm text-gray-700"
                >Nombre</label
              >
              <input
                type="text"
                v-model.trim="nombre"
                id="nombre"
                autocomplete="off"
                class="
                  mt-1
                  block
                  w-full
                  shadow-sm
                  sm:text-sm
                  border-gray-700
                  rounded-md
                "
              />
            </div>
            <div class="col-span-6 sm:col-span-3">
              <label for="telefono" class="block text-sm text-gray-700"
                >Telefono</label
              >
              <input
                type="text"
                v-model.trim="telefono"
                id="telefono"
                autocomplete="off"
                class="
                  mt-1
                  block
                  w-full
                  shadow-sm
                  sm:text-sm
                  border-gray-700
                  rounded-md
                "
              />
            </div>
          </div>
        </div>
        <div class="px-4 py-3 bg-gray-50 text-right sm:px-6">
          <button
            type="submit"
            class="
              inline-flex
              justify-center
              py-2
              px-4
              border border-transparent
              shadow-sm
              text-sm
              rounded-md
              text-white
              bg-blue-600
              hover:bg-blue-700
              focus:outline-none
            "
          >
            Save
          </button>
        </div>
      </div>
    </form>
  </div>

  <div class="relative overflow-x-auto sm:rounded-lg">
    <table
      class="w-full text-sm text-left text-gray-500 dark:text-gray-400"
      v-show="optionTable"
    >
      <thead class="text-xs text-white uppercase bg-gray-50 dark:bg-gray-700">
        <tr>
          <th scope="col" class="px-6 py-3">ID: {{ clientePagos.id }}</th>
          <th scope="col" class="px-6 py-3" colspan="2">
            NOMBRE: {{ clientePagos.nombre }}, Teléfono
            {{ clientePagos.telefono }}, Último pago:
            {{ validDate(clientePagos.ultimoPago) }}
          </th>
        </tr>
      </thead>
      <tbody>
        <tr
          class="bg-white border-b"
          v-for="pago in clientePagos.pagos"
          :key="pago.id"
        >
          <th scope="row" class="px-6 py-4 whitespace-nowrap">{{ pago.id }}</th>
          <td class="px-6 py-4">${{ decimalsWithCommas(pago.monto) }}</td>
          <td class="px-6 py-4"> {{ validDate(pago.fechaPago) }}</td>
        </tr>
      </tbody>
      <button
        @click="regresar"
        class="
          inline-flex
          justify-center
          py-2
          px-4
          border border-transparent
          shadow-sm
          text-sm
          rounded-md
          text-white
          bg-blue-600
          hover:bg-blue-700
          focus:outline-none
        "
      >
        Regresar
      </button>
    </table>

    <table
      class="w-full text-sm text-left text-gray-500 dark:text-gray-400"
      v-show="!optionTable"
    >
      <thead
        class="
          text-xs text-gray-700
          uppercase
          bg-gray-50
          dark:bg-gray-700 dark:text-gray-400
        "
      >
        <tr>
          <th scope="col" class="px-6 py-3">Nombre</th>
          <th scope="col" class="px-6 py-3">Telefono</th>
        </tr>
      </thead>
      <tbody>
        <tr
          class="bg-white border-b click hover:bg-gray-100 hover:text-black"
          v-for="cliente in clientes"
          :key="cliente.id"
          @click="consultarCliente(cliente.id)"
        >
          <td class="px-6 py-4">{{ cliente.nombre }}</td>
          <td class="px-6 py-4">{{ cliente.telefono }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
import { ref, computed, onMounted } from "vue";
import moment from "moment";
import "moment/locale/es";

export default {
  name: "FormCliente",
  setup() {
    onMounted(() => {
      consultarClietnes();
    });
    const nombre = ref("");
    const telefono = ref("");
    const clientes = ref([]);
    const clientePagos = ref([]);
    const optionTable = ref(false);
    const URLAPI = "https://localhost:7066/api/Clientes/";

    const consultarClietnes = async () => {
      try {
        const reqs = await fetch(URLAPI);
        const resp = await reqs.json();
        clientes.value = resp;
      } catch (error) {
        throw new Error(error);
      }
    };
    const consultarCliente = async (id) => {
      try {
        const reqs = await fetch(`${URLAPI}clientepagos/${id}`);
        const resp = await reqs.json();
        clientePagos.value = resp;
        optionTable.value = true;
      } catch (error) {
        throw new Error(error);
      }
    };
    const regresar = () => {
      optionTable.value = false;
    };
    const submit = async () => {
      if (nombre.value !== "" && telefono.value !== "") {
        try {
          const data = {
            nombre: nombre.value,
            telefono: telefono.value,
            ultimoPago: null,
          };
          const reqs = await fetch(`${URLAPI}`, {
            body: JSON.stringify(data),
            method: "post",
            headers: {
              "Content-Type": "application/json",
            },
          });
          const resp = await reqs.json();
          console.log(resp);
        } catch (error) {
          throw new Error(error);
        } finally {
          limpiarFormulario();
        }
      }
    };
    const limpiarFormulario = () => {
      optionTable.value = false;
      nombre.value = "";
      telefono.value = "";
      consultarClietnes();
    };
    const decimalsWithCommas = (decimal) => {
      var num = Number(decimal);
      return num.toFixed(2).replace(/(\d)(?=(\d{3})+(?!\d))/g, "$1,");
    };
    const validDate = date => {
      return date === "0001-01-01T00:00:00" ? '- - -' : moment(date).format("D MMMM YYYY, h:mm:ss a");
    };

    return {
      nombre,
      telefono,
      clientes,
      optionTable,
      clientePagos,

      consultarCliente,
      regresar,
      submit,
      validDate,

      decimalsWithCommas,
      moment,
    };
  },
};
</script>

<style scoped>
.click {
  cursor: pointer;
}
</style>